//
//  AlbumDetailView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import SwiftUI

struct AlbumDetailView: View {
  @State var isEdit = false
  
  // 이미지
  @State var isImageClick: Bool = false
  @State var selectImage: UIImage = UIImage()
  @State var selectImageIndex: Int = -1

  @State var isBookmarkClick: Bool = false
  @State var isCommentClick: Bool = false
  @State var isEllipsisClick: Bool = false
  let info = MockData().albumDetail
  
  var body: some View {
    NavigationView {
      VStack {
        AlbumDetailList(isImageClick: $isImageClick, selectImage: $selectImage, selectImageIndex: $selectImageIndex, isBookmarkClick: $isBookmarkClick, isCommentClick: $isCommentClick, isEllipsisClick: $isEllipsisClick)
        
        // 이미지 click
        NavigationLink("", destination: EmptyView(), isActive: $isImageClick)
        
        // 댓글 click
        NavigationLink("", destination: EmptyView(), isActive: $isCommentClick)
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
