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
  @State var isNext = false
  @ObservedObject var fetcher = AudioRecorderURLViewModel()
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
          .foregroundColor(Color.white)
          .offset(x: -35)
        Text("\(audioRecorder.seconds < 10 ? "0" : "")\(audioRecorder.seconds)" + " :")
          .foregroundColor(Color.white)
        Text("\(audioRecorder.microSeconds < 10 ? "0" : "")\(audioRecorder.microSeconds)")
          .foregroundColor(Color.white)
          .offset(x: 30)
      }
    }
    .frame(width: Screen.maxWidth, height: Screen.maxHeight)
  }
  
  var recordButtonArea: some View {
    VStack {
      Spacer()
      VStack {
        HStack {
          Button(action: {
            if self.audioRecorder.isRecording{
              self.audioRecorder.stopRecording()
            } else {
              self.audioRecorder.startRecording()
            }
          }, label: {
            ZStack {
              if audioRecorder.isRecording { // 녹음 시작
                Circle()
                  .frame(width: 64, height: 64)
                  .foregroundColor(Color.white)

                Image(systemName: "pause.fill")
                  .resizable()
                  .font(.system(size: 32))
                  .frame(width: 28, height: 32)
                  .foregroundColor(Color(hex: "D81B60"))
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
        }
        .padding(.top, 16)
        Spacer()
      }
      .frame(width: Screen.maxWidth, height: Screen.maxWidth * 0.3)
      .background(Color(hex: "#161616").ignoresSafeArea(edges: .bottom))
    }
  }
  
  func existRecord() -> Bool {
    let fileManager = FileManager.default
    let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let path = documentDirectory.path
    let directoryContents = try! fileManager.contentsOfDirectory(atPath: path)
    
    return directoryContents.count == 1 && !audioRecorder.isRecording
  }
  
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        ZStack {
          recordBarArea // 녹음 Bar 영역
          
          Color.clear
            .ignoresSafeArea()
            .overlay(
              AlbumRecordAddNavigationBar(isNext: $isNext, existRecord: .constant(record), recordParent: self, safeTop: geometry.safeAreaInsets.top) // Navigation Bar
            )
            .overlay(
              recordButtonArea
            )
          
          // 날짜 선택으로 이동
          NavigationLink("", destination: AlbumSelectDateView(title: "녹음 올리기", isCameraCancle: .constant(false), recordParent: self), isActive: $isNext)
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .ignoresSafeArea()
      }
    }
    .onAppear {
      audioRecorder.requestAuthorization(parant: self)
      fetcher.deleteAllRecording() } // 내장 녹음 전체 삭제
    .onDisappear { UITabBar.showTabBar() }
  }
}

struct AlbumRecordAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumRecordAddView()
  }
}
