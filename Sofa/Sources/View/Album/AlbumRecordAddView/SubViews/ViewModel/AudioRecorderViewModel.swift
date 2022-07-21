//
//  AudioRecorderViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/17.
//

import Foundation
import AVFoundation

class AudioRecorderViewModel: NSObject, ObservableObject {
  @Published public var soundSamples: [Bool]
  @Published public var isRecording = false
  @Published public var url: URL?
  
  // 재생
  @Published var isPlaying = false
  var audioPlayer: AVAudioPlayer!
  
  // 시간 Properties
  @Published var minutes: Int = 0
  @Published var seconds: Int = 0
  @Published var microSeconds: Int = 0
  private var timer: Timer
  private var time: Double = 0
  
  private var audioRecorder: AVAudioRecorder
  private var currentStepbar: Int // 색상 변경해야하는 step bar
  private let numberOfStepbar: Int // 전체 step bar
  
  // init
  init(numberOfSamples: Int) {
    self.numberOfStepbar = numberOfSamples // numberOfSamples > 0 이여야 함
    self.soundSamples = [Bool](repeating: false, count: numberOfSamples)
    self.currentStepbar = 0
    self.audioRecorder = AVAudioRecorder()
    self.timer = Timer()
  }
  
  func requestAuthorization(parant: AlbumRecordAddView) {
    AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
      if !granted {
        parant.presentable.wrappedValue.dismiss()
      }
    })
  }
  
  // 녹음 시작
  func startRecording() {
    let audioSession = AVAudioSession.sharedInstance() // 싱글톤 인스턴스 획득
    
    let recorderSettings: [String:Any] = [
      AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless), // 녹음 포맷, 코어 오디오에 정의된 포맷 문자 사용
      AVSampleRateKey: 44100.0, // 샘플링 rate
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue // 녹음 품질
    ]
    
    // 저장할 파일 경로
    let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    // Date Formatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd 녹음"
    
    self.url = documentPath.appendingPathComponent("\(dateFormatter.string(from: Date())).m4a")
    
    do {
      audioRecorder = try AVAudioRecorder(url: self.url!, settings: recorderSettings)
      
      // 오디오 세션 카테고리, 모드, 옵션을 설정
      try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
      self.isRecording = true // 녹음 시작
      
      stopInit()
      startMonitoring() // 시간 및 bar 위치 계산
    } catch {
      fatalError(error.localizedDescription)
    }
  }
  
  // 녹음 정지 & 초기화
  func stopRecording(){
    isRecording = false
    timer.invalidate()
    microSeconds = 0
    seconds = 0
    minutes = 0
    time = 0
    audioRecorder.stop()
    self.startInit(audio: self.url!)
    self.currentStepbar = 0
    self.soundSamples = [Bool](repeating: false, count: numberOfStepbar)
  }
  
  // 소리를 수치로 바꿔주는 함수
  private func normalizeSoundLevel(level: Float) -> Int {
    let level = max(0, CGFloat(level) + CGFloat(numberOfStepbar)) // between 0 ~ (level + numberOfStepbar)
    return Int(level) % numberOfStepbar
  }
  
  // 시간 및 bar 위치 계산
  private func startMonitoring() {
    audioRecorder.isMeteringEnabled = true
    audioRecorder.record()
    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [self] (timer) in
      self.audioRecorder.updateMeters()
      
      self.currentStepbar = normalizeSoundLevel(level: self.audioRecorder.averagePower(forChannel: 0)) // 음성의 level의 크기에 따라
      self.soundSamples = [Bool](repeating: true, count: currentStepbar) + [Bool](repeating: false, count:  self.numberOfStepbar - currentStepbar)
      
      self.time += 1
      
      self.microSeconds = Int(self.time) % 100
      self.seconds = Int(self.time * 0.01) % 60
      self.minutes = (Int(self.time * 0.01) / 60) % 60
    })
  }
  
  // 개발용 - 검색
  func search() {
    let fileManager = FileManager.default
    let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let path = documentDirectory.path
    let directoryContents = try! fileManager.contentsOfDirectory(atPath: path)
    print(directoryContents)
  }
  
  // [URL] 범위 삭제
  func deleteRecording(urlsToDelete: URL?) {
    guard let urlsToDelete = urlsToDelete else { return }
    do {
      try FileManager.default.removeItem(at: urlsToDelete)
    } catch {
      print("File could not be deleted!")
    }
  }
}

//MARK: - 재생
extension AudioRecorderViewModel: AVAudioPlayerDelegate {
  func startInit (audio: URL) {
    let playbackSession = AVAudioSession.sharedInstance()
    
    do {
      try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
    } catch {
      print("기기의 스피커를 통해 재생하지 못했습니다")
    }
    
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: audio)
      audioPlayer.delegate = self
    } catch {
      print("재생 실패")
    }
  }
  
  func startPlayback() {
    playMonitoring()
    isPlaying = true
  }
  
  func playMonitoring() {
    audioPlayer.isMeteringEnabled = true
    audioPlayer.play()
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [self] (timer) in
      self.audioPlayer.updateMeters()
      
      self.currentStepbar = normalizeSoundLevel(level: Float(averagePowerFromAllChannels())) // 음성의 level의 크기에 따라
      self.soundSamples = [Bool](repeating: true, count: currentStepbar) + [Bool](repeating: false, count:  self.numberOfStepbar - currentStepbar)
      
      self.time += 1
      
      self.microSeconds = Int(self.time) % 100
      self.seconds = Int(self.time * 0.01) % 60
      self.minutes = (Int(self.time * 0.01) / 60) % 60
    })
  }
  
  // 모든 채널의 평균 power 계산
  private func averagePowerFromAllChannels() -> CGFloat {
    var power: CGFloat = 0.0
    (0..<audioPlayer.numberOfChannels).forEach { (index) in
      power = power + CGFloat(audioPlayer.averagePower(forChannel: index))
    }
    return power / CGFloat(audioPlayer.numberOfChannels)
  }
  
  func pausePlayback() {
    isPlaying = false
    audioPlayer.pause()
    timer.invalidate()
  }
  
  // 재생 정지 & 초기화
  func stopInit() {
    if let audioPlayer = audioPlayer {
      audioPlayer.stop() // play중 녹음버튼을 누를 경우,
    }
    timer.invalidate()
    microSeconds = 0
    seconds = 0
    minutes = 0
    time = 0
    self.currentStepbar = 0
    self.soundSamples = [Bool](repeating: false, count: numberOfStepbar)
  }
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    if flag {
      stopInit()
      isPlaying = false
    }
  }
}
