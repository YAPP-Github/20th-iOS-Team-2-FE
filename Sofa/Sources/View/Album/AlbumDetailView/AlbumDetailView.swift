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
  
  // 즐겨찾기
  @State var isBookmarkClick: Bool = false
  @State private var messageData: ToastMessage.MessageData = ToastMessage.MessageData(title: "즐겨찾기 등록", type: .Registration)
  
  @State var isCommentClick: Bool = false   // 댓글
  @State var isEllipsisClick: Bool = false  // 설정
  @State var isUpdateDate: Bool = false  // 설정
  let info = MockData().albumDetail
  
  var actionSheetView: some View {
    ActionSheetCard(
      isShowing: $isEllipsisClick,
      items: [
        ActionSheetCardItem(systemIconName: "arrow.down", label: "다운로드") {
          isEllipsisClick = false
        },
        ActionSheetCardItem(systemIconName: "calendar", label: "날짜 수정") {
          isUpdateDate = true
          isEllipsisClick = false
        },
        ActionSheetCardItem(systemIconName: "trash", label: "삭제", foregrounColor: Color(hex: "#EC407A")) {
          isEllipsisClick = false
        }
      ],
      outOfFocusOpacity: 0.2,
      itemsSpacing: 0
    )
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack {
          AlbumDetailList(isImageClick: $isImageClick, selectImage: $selectImage, selectImageIndex: $selectImageIndex, isBookmarkClick: $isBookmarkClick, isCommentClick: $isCommentClick, isEllipsisClick: $isEllipsisClick)
          
          // 이미지 click
          NavigationLink("", destination: AlbumImageDetailView(image: selectImage, index: selectImageIndex), isActive: $isImageClick)
          
          // 댓글 click
          NavigationLink("", destination: EmptyView(), isActive: $isCommentClick)
          
        }
        .toastMessage(data: $messageData, isShow: $isBookmarkClick)
        .navigationBarWithTextButtonStyle(isNextClick: $isEdit, isDisalbeNextButton: .constant(false), info.title, nextText: "편집", Color.init(hex: "#43A047"))
        .fullScreenCover(isPresented: $isUpdateDate) {
          AlbumSelectDateView(title: "날짜 수정", isCameraCancle: .constant(false))
        }
        .edgesIgnoringSafeArea([.bottom]) // Bottom만 safeArea 무시
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .navigationBarHidden(true)
      .onAppear { UITabBar.hideTabBar() }
      .onDisappear { UITabBar.showTabBar() }
      
      actionSheetView // 바텀 Sheet
    }
  }
}

struct AlbumDetailView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDetailView()
  }
}
