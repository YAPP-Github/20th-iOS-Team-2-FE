//
//  AlbumImageDetailView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/28.
//

import SwiftUI

struct AlbumImageDetailView: View {
  @State var touchImage = false
  
  // 댓글
  @State var isCommentClick: Bool = false   // 댓글
  let isPreCommentClick: Bool // 이전 화면에서 댓글
  
  @State var isEllipsisClick: Bool = false  // 설정
  
  // 다운로드
  @State var isDownloadClick: Bool = false  // 다운로드
  @State private var messageData: ToastMessage.MessageData = ToastMessage.MessageData(title: "다운로드 완료", type: .Registration)
  
  @State var isUpdateDate: Bool = false  // 날짜 수정
  var image: UIImage
  var index: Int
  
  var actionSheetView: some View {
    ActionSheetCard(
      isShowing: $isEllipsisClick,
      items: [
        ActionSheetCardItem(systemIconName: "arrow.down", label: "다운로드") {
          UIImageWriteToSavedPhotosAlbum(image, self, nil, nil) // 이미지 다운로드
          isEllipsisClick = false
          isDownloadClick = true
        },
        ActionSheetCardItem(systemIconName: "calendar", label: "날짜 수정") {
          isUpdateDate = true
          isEllipsisClick = false
        },
        ActionSheetCardItem(systemIconName: "trash", label: "삭제", foregrounColor: Color(hex: "#EC407A")) {
          isEllipsisClick = false
        }
      ],
      outOfFocusOpacity: 0.2
    )
  }
  
  var body: some View {
    ZStack {
      Button(action: {
        touchImage.toggle()
      }) {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
        //              .frame(width: Screen.maxWidth, height: Screen.maxHeight) // 임시
          .pinchToZoom()
      }
      
      Color.clear
        .ignoresSafeArea()
        .overlay(
          AlbumImageDetailNavigationBar(safeTop: Screen.safeAreaTop)
            .opacity(touchImage ? 0 : 1) // show/hidden toggle 기능
        )
        .overlay(
          AlbumImageDetailSettingBar(isCommentClick: $isCommentClick, isEllipsisClick: $isEllipsisClick, info: MockData().albumDetail.elements[0]) // 임시
            .opacity(touchImage ? 0 : 1) // show/hidden toggle 기능
        )
    }
    .background(Color.black)
    .ignoresSafeArea()
    .navigationBarHidden(true) // 이전 Navigation bar 무시
    .toastMessage(data: $messageData, isShow: $isDownloadClick)
    .fullScreenCover(isPresented: $isCommentClick) {
      AlbumCommentView(isShowing: $isCommentClick)
        .background(BackgroundCleanerView())
    }
    .fullScreenCover(isPresented: $isEllipsisClick) {
      actionSheetView
        .background(BackgroundCleanerView())
    }
    .onAppear {
      if isPreCommentClick { // Detail View에서 댓글 버튼을 눌렀을때
        isCommentClick = true
      }
    }
  }
}

struct AlbumImageDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.elements[6]
    
    AlbumImageDetailView(isPreCommentClick: false, image: UIImage(named: data.link)!, index: 0)
  }
}
