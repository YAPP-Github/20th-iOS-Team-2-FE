//
//  AlbumDetailView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import SwiftUI

struct AlbumDetailView: View {
  @State var isNext = false
  @State var isEdit = false
  let info = MockData().albumDetail
  
  var body: some View {
    NavigationView {
      VStack {
        AlbumDetailList(isNext: $isNext)
        
        NavigationLink("", destination: AlbumRecordAddView(), isActive: $isNext)
      }
      .navigationBarWithTextButtonStyle(isNextClick: $isEdit, isDisalbeNextButton: .constant(false), info.title, nextText: "편집", Color.init(hex: "#43A047"))
      .edgesIgnoringSafeArea([.bottom]) // Bottom만 safeArea 무시
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarHidden(true)
    .onAppear { UITabBar.toogleTabBarVisibility() }
    .onDisappear { UITabBar.toogleTabBarVisibility() }
  }
}

struct AlbumDetailView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDetailView()
  }
}
