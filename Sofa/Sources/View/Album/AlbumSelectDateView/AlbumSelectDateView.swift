//
//  AlbumSelectDateView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import SwiftUI

struct AlbumSelectDateView: View {
  @Environment(\.presentationMode) var presentable
  @ObservedObject var tabbarManager = TabBarManager.shared
  @ObservedObject var viewModel = AlbumUploadViewModel()
  @State var currentDate: Date = Date()
  
  var title: String = "올리기"
  let buttonColor: Color = Color.init(hex: "#43A047") // 임시
  
  // 사진
  @Binding var isCameraCancle: Bool // 카메라 사진
  var photoParent: AlbumPhotoAddView? // 갤러리 사진
  var images: [UIImage]? // 갤러리 사진들, 카메라
  
  // 녹음
  @State var recordTitle: String = ""
  var recordParent: AlbumRecordAddView?
  var recordUrl: URL? // 녹음
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 0) {
          if recordParent != nil { // 녹음일 경우
            VStack(spacing: 0) {
              Divider()
              Spacer() // 임시 - 여백용
                .frame(height: 8)
              HStack {
                Spacer()
                TextField(recordUrl!.lastPathComponent.split(separator: ".").first!, text: $recordTitle)
                  .padding(16)
                  .background(Color.init(hex: "#FAF8F0")) // 임시
                  .font(.custom("Pretendard-Medium", size: 18))
                  .foregroundColor(Color.black)
                  .cornerRadius(6)
                  .modifier(DismissingKeyboard())
                Spacer()
              }
              .frame(width: Screen.maxWidth, height: 80) // 임시 - 높이
              .background(Color.white)
            }
          }
          Divider()
          Spacer() // 임시 - 여백용
            .frame(height: 8)
          Group {
            GeneralDatePickerView(showDatePicker: .constant(true), enableToggle: .constant(false), currentDate: $currentDate)
          }
          .padding(EdgeInsets(top: 16, leading: 16, bottom: 12, trailing: 16))
          .background(Color.white)
          Divider()
          Spacer()
        }
      }
      .modifier(DismissingKeyboard())
      .background(Color.init(hex: "#FAF8F0")) // 임시
      .navigationBarItems(
        leading: Button(action: {
          if photoParent == nil && recordParent == nil { // 카메라로 들어왔을 경우,
            isCameraCancle = true // 카메라 imagePicker로 이동
          }
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Image(systemName: "chevron.left")
            Text("이전")
              .font(.custom("Pretendard-Medium", size: 16))
              .fontWeight(.semibold)
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          var recordTitle = ""
          if photoParent != nil { // 갤러리 사진들
            photoParent?.presentable.wrappedValue.dismiss()
          } else if recordParent != nil { // 녹음
            recordParent?.presentable.wrappedValue.dismiss()
            recordTitle = String(recordUrl!.lastPathComponent.split(separator: ".").first!)
          } else { // 카메라
            presentable.wrappedValue.dismiss()
          }
          tabbarManager.showTabBar = true
          let dateStr = currentDate.getFormattedDate(format: "yyyy-MM-dd") + "T" + Date().getFormattedDate(format: "hh:mm:ss")
          viewModel.fetchUploadFiles(date: dateStr, images: images, title: self.recordTitle == "" ? recordTitle : self.recordTitle, audio: recordUrl) // 업로드
          UITabBar.showTabBar()
        }, label: {
          HStack(spacing: 0) {
            Text("올리기")
              .font(.custom("Pretendard-Medium", size: 16))
              .fontWeight(.semibold)
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle(title)
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

struct AlbumSelectDateView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumSelectDateView(isCameraCancle: .constant(false), images: MockData().photoList.map{UIImage(named: $0)!})
  }
}
