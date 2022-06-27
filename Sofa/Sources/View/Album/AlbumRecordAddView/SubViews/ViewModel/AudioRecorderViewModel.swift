//
//  AudioRecorderViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/17.
//

import Foundation
import AVFoundation

class AudioRecorderViewModel: ObservableObject {
  @Published public var soundSamples: [Bool]
  @Published public var isRecording = false
  
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
    
    let url = documentPath.appendingPathComponent("\(dateFormatter.string(from: Date()))")
    
    do {
      audioRecorder = try AVAudioRecorder(url: url, settings: recorderSettings)
      
      // 오디오 세션 카테고리, 모드, 옵션을 설정
      try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
      self.isRecording = true // 녹음 시작
      
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
}
