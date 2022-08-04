//
//  AlbumRecordNavigationBar.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/17.
//

import SwiftUI

struct AlbumRecordNavigationBar: View {
  @Environment(\.presentationMode) var presentable
  @ObservedObject var tabbarManager = TabBarManager.shared
  @ObservedObject private var audioRecorder = AudioRecorderViewModel(numberOfSamples: 21)
  @Binding var isNext: Bool
  @Binding var existRecord: Bool
  @Binding var colorScheme: ColorScheme // status bar color
  let title: String
  var recordParent: AlbumRecordAddView?
  var recordUrl: URL?
  let safeTop: CGFloat
  
  var body: some View {
    VStack {
      VStack {
        Spacer()
        HStack {
          Button(action: {
            if recordParent != nil {
              tabbarManager.showTabBar = true
              recordParent!.presentable.wrappedValue.dismiss()
            } else {
              presentable.wrappedValue.dismiss()
            }
            colorScheme = .light
            audioRecorder.deleteRecording(urlsToDelete: recordUrl)
          }) {
            if recordParent != nil {
              Text("취소")
            } else {
              HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                Text("이전")
              }
            }
          }
          .foregroundColor(Color.white)
          
          Spacer()
          
          Text(title)
            .foregroundColor(Color.white)
            .padding(.trailing, recordParent != nil ? 0 : 18)
          
          Spacer()
          
          Button(action: {
            isNext = true
          }) {
            Text("완료")
              .foregroundColor(existRecord ? Color(hex: "#EC407A"): Color(hex: "#161616"))
          }
          .disabled(!existRecord)
        }
      }
      .font(.custom("Pretendard-Bold", size: 16))
      .frame(height: safeTop + 10)
      .frame(maxWidth: .infinity, alignment: .center)
      .padding(EdgeInsets(top: 20, leading: 24, bottom: 15, trailing: 24))
      .background(Color(hex: "#161616").ignoresSafeArea(edges: .top))
      Spacer()
    }
  }
}

struct AlbumRecordAddNavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    AlbumRecordNavigationBar(isNext: .constant(true), existRecord: .constant(true), colorScheme: .constant(.light), title: "새로운 녹음", recordParent: AlbumRecordAddView(), safeTop: 10)
  }
}
