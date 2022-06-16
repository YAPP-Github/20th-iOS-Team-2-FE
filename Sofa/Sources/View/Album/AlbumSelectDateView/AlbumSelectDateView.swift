//
//  AlbumSelectDateView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import SwiftUI

struct AlbumSelectDateView: View {
  @Environment(\.presentationMode) var presentable
  @State var isNext = false
  @State var isDisalbeNextButton: Bool = false
  var parent: AlbumPhotoAddView
  var title: String = "사진 올리기"
  let buttonColor: Color = Color.init(hex: "#43A047")
  
  var body: some View {
    NavigationView {
      VStack {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      }
      .navigationBarItems(
        leading: Button(action: {
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Image(systemName: "chevron.left")
            Text("취소")
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          parent.presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Text("사진 올리기")
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
  }
}

struct AlbumSelectDateView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumSelectDateView(parent: AlbumPhotoAddView())
  }
}
