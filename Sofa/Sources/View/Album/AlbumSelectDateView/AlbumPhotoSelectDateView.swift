//
//  AlbumPhotoSelectDateView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/16.
//

import SwiftUI

struct AlbumPhotoSelectDateView: View {
  @Environment(\.presentationMode) var presentable
  @State var isNext = false
  @State var isDisalbeNextButton: Bool = false
  var title: String = "사진 올리기"
  let buttonColor: Color = Color.init(hex: "#43A047")
  
  // 갤러리 사진들
  @State var imageList: [SelectedImages]? // 갤러리 사진들
  var parent: AlbumPhotoAddView?

  // 카메라 사진
  @Binding var isCameraCancle: Bool
  @State var image: UIImage? // 카메라 사진

  var body: some View {
    NavigationView {
      VStack {
        Text("카메라 날짜 선택 View")
      }
      .navigationBarItems(
        leading: Button(action: {
          if image != nil { // 카메라로 들어왔을 경우,
            isCameraCancle = true // 카메라 imagePicker로 이동
          }
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Image(systemName: "chevron.left")
            Text("이전")
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Text("올리기")
          }
        })
        .disabled(isDisalbeNextButton)
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
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarHidden(true)
    .onAppear { UITabBar.toogleTabBarVisibility() }
    .onDisappear { UITabBar.toogleTabBarVisibility() }
  }
}

struct AlbumCarmeraAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumPhotoSelectDateView(isCameraCancle: .constant(false))
  }
}
