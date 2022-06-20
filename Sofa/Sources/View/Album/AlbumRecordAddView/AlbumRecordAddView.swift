//
//  AlbumRecordAddView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI

struct AlbumRecordAddView: View {
  @ObservedObject private var audioRecorder = AudioRecorderViewModel(numberOfSamples: 21)
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        ZStack {
          Rectangle() // 녹음 배경 영역
            .frame(width: Screen.maxWidth, height: Screen.maxHeight - Screen.maxWidth * 0.3)
            .foregroundColor(Color.black) // 임시
          
          VStack { // 녹음 Bar 영역
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
        }
        
        ZStack(alignment: .top) { // 녹음 버튼 영역
          Rectangle()
            .frame(width: Screen.maxWidth, height: Screen.maxWidth * 0.3)
            .foregroundColor(Color(hex: "161616")) // 임시
          
          ZStack {
            Button(action: {
              if self.audioRecorder.isRecording{
                self.audioRecorder.stopRecording()
              }else{
                self.audioRecorder.startRecording()
              }
            }, label: {
              ZStack {
                Circle()
                  .frame(width: 64, height: 64)
                  .foregroundColor(Color.white)
                
                if audioRecorder.isRecording {
                  Rectangle()
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color(hex: "D81B60"))
                    .cornerRadius(8)
                } else {
                  Circle()
                    .frame(width: 48, height: 48)
                    .foregroundColor(Color(hex: "D81B60"))
                }
              }
            })
          }
          .padding(16)
        }
      }
      .ignoresSafeArea()
      .navigationBarOnlyCancelButtonStyle("새로운 녹음")
    }
  }
}

struct AlbumRecordAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumRecordAddView()
  }
}
