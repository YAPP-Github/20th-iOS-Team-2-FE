//
//  AlbumRecordAddView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI
import AVFoundation

struct AlbumRecordAddView: View {
  @Environment(\.presentationMode) var presentable
  @ObservedObject private var audioRecorder = AudioRecorderViewModel(numberOfSamples: 21)
  @State var colorScheme: ColorScheme = .dark
  @State var isNext = false
  var record: Bool { return existRecord() }
  
  // 녹음 Bar 영역
  var recordBarArea: some View {
    VStack(spacing: 8) {
      HStack(alignment: .center, spacing: 4) {
        ForEach(self.audioRecorder.soundSamples, id: \.self) { step in
          AudioBarView(color: Color(hex: "4CAF50"), isStep: step)
        }
      }
      
      ZStack { // 시간 영역
        Text("\(audioRecorder.minutes < 10 ? "0" : "")\(audioRecorder.minutes)" + " :")
          .offset(x: -35)
        Text("\(audioRecorder.seconds < 10 ? "0" : "")\(audioRecorder.seconds)" + " :")
        Text("\(audioRecorder.microSeconds < 10 ? "0" : "")\(audioRecorder.microSeconds)")
          .offset(x: 30)
      }
      .foregroundColor(Color.white)
      .font(.custom("Pretendard-Medium", size: 16))
    }
    .frame(width: Screen.maxWidth, height: Screen.maxHeight)
  }
  
  // 녹음 재생 버튼
  var playButton: some View {
    Button(action: {
      self.audioRecorder.startPlayback()
    }) {
      ZStack {
        Circle()
          .frame(width: 64, height: 64)
          .foregroundColor(Color.white)
        
        Image(systemName: "play.fill")
          .resizable()
          .scaledToFit()
          .offset(x: 2)
          .frame(height: 28)
          .foregroundColor(Color(hex: "D81B60"))
      }
    }
  }
  
  // 정지 버튼
  var puaseButton: some View {
    Group {
      Circle()
        .frame(width: 64, height: 64)
        .foregroundColor(Color.white)
      
      Image(systemName: "pause.fill")
        .resizable()
        .scaledToFit()
        .frame(height: 28)
        .foregroundColor(Color(hex: "D81B60"))
    }
  }
  
  var recordButtonArea: some View {
    VStack {
      Spacer()
      VStack {
        HStack(spacing: 24) {
          Button(action: {
            if self.audioRecorder.isRecording{
              self.audioRecorder.stopRecording()
            } else {
              self.audioRecorder.startRecording()
            }
          }, label: {
            ZStack {
              if audioRecorder.isRecording { // 녹음 시작
                puaseButton // 정지 버튼
              } else { // 녹음 끝
                Circle()
                  .frame(width: 64, height: 64)
                  .foregroundColor(Color(hex: "D81B60"))
                
                Image(systemName: "record.circle")
                  .resizable()
                  .frame(width: 32, height: 32)
                  .foregroundColor(Color.white)
              }
            }
          })
          if record {
            if audioRecorder.isPlaying == false {
              playButton // 재생 버튼
            } else {
              Button(action: {
                self.audioRecorder.pausePlayback()
              }) {
                ZStack {
                  puaseButton // 정지 버튼
                }
              }
            }
          }
        }
        .padding(.top, 16)
        Spacer()
      }
      .frame(width: Screen.maxWidth, height: Screen.maxWidth * 0.3)
      .background(Color(hex: "#161616").ignoresSafeArea(edges: .bottom))
    }
  }
  
  func existRecord() -> Bool {
    return audioRecorder.url != nil && !audioRecorder.isRecording
  }
  
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ZStack {
          recordBarArea // 녹음 Bar 영역
          
          Color.clear
            .ignoresSafeArea()
            .overlay(
              AlbumRecordNavigationBar(isNext: $isNext, existRecord: .constant(record), colorScheme: $colorScheme, title: "새로운 녹음", recordParent: self, recordUrl: audioRecorder.url, safeTop: geometry.safeAreaInsets.top) // Navigation Bar
            )
            .overlay(
              recordButtonArea
            )
          
          // 날짜 선택으로 이동
          if isNext {
            NavigationLink("", destination: AlbumSelectDateView(title: "녹음 올리기", isCameraCancle: .constant(false), colorScheme: $colorScheme, recordParent: self, recordUrl: audioRecorder.url), isActive: $isNext)
              .onAppear {
                self.audioRecorder.stopInit()
              }
          }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .ignoresSafeArea()
      }
    }
    .preferredColorScheme(colorScheme)
    .onAppear {
      audioRecorder.requestAuthorization(parant: self)
    }
    .onDisappear {
      self.audioRecorder.stopInit()
      UITabBar.showTabBar()
    }
  }
}

struct AlbumRecordAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumRecordAddView()
  }
}
