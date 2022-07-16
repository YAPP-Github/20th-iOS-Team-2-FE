//
//  AlbumEditDateView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/16.
//

import SwiftUI

struct AlbumEditDateView: View {
  @Environment(\.presentationMode) var presentable
  @State var showDatePicker: Bool = true
  @State var enableToggle: Bool = false
  @State var currentDate: Date = Date()
  let buttonColor: Color = Color.init(hex: "#43A047") // 임시
  var albumId: String?   // 앨범 날짜 수정
  var photoId: String?   // 사진 날짜 수정
  var recordId: String?  // 녹음 날짜 수정

  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        Divider()
        Spacer() // 임시 - 여백용
          .frame(height: 8)
        Group {
          GeneralDatePickerView(showDatePicker: $showDatePicker, enableToggle: $enableToggle, currentDate: $currentDate)
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
        .background(Color.white)
        Spacer()
      }
      .background(Color.init(hex: "#FAF8F0")) // 임시
      .navigationBarItems(
        leading: Button(action: {
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Text("취소")
              .font(.custom("Pretendard-Medium", size: 16))
              .fontWeight(.semibold)
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          if albumId != nil {         // 앨범
            print("앨범 날짜 수정")
          } else if photoId != nil {  // 사진
            print("사진 날짜 수정")
          } else if recordId != nil { // 녹음
            print("녹음 날짜 수정")
          }
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Text("수정")
              .font(.custom("Pretendard-Medium", size: 16))
              .fontWeight(.semibold)
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("날짜 수정")
      .onAppear {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor =
        UIColor.systemBackground.withAlphaComponent(1)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
      }
      .edgesIgnoringSafeArea([.bottom]) // Bottom만 safeArea 무시
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarHidden(true)
  }
}

struct AlbumEditDateView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumEditDateView()
  }
}
