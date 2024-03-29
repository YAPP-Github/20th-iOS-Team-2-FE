//
//  AlbumImageDetailView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/28.
//

import SwiftUI

struct AlbumImageDetailView: View {
  @Environment(\.presentationMode) var presentable
  @ObservedObject var authorizationViewModel = AuthorizationViewModel()
  @ObservedObject var listCellViewModel = AlbumDetailCellViewModel()
  @StateObject var commentViewModel: CommentViewModel

  @State var touchImage = false
  @Binding var colorScheme: ColorScheme // status bar color
  let isDate: Bool // 날짜/유형별 확인
  var info: AlbumDetailElement?
  var image: UIImage
  let albumId: Int
  
  // 즐겨찾기
  @State var isBookmarkClick: Bool = false
  @State var messageData: ToastMessage.MessageData = ToastMessage.MessageData(title: "즐겨찾기 등록", type: .Registration)
  
  // 댓글
  @State var isCommentClick: Bool = false   // 댓글
  let isPreCommentClick: Bool // 이전 화면에서 댓글
  
  @State var isEllipsisClick: Bool = false  // 설정
  @State var isUpdateDate: Bool = false  // 날짜 수정
  
  // Toast Message
  @State var isToastMessage: Bool = false
  @State var messageData2: ToastMessage.MessageData = ToastMessage.MessageData(title: "다운로드 완료", type: .Registration)
  
  var actionSheetView: some View {
    ActionSheetCard(
      isShowing: $isEllipsisClick,
      items: [
        ActionSheetCardItem(systemIconName: "arrow.down", label: "다운로드") {
          isEllipsisClick = false
          messageData2 = ToastMessage.MessageData(title: "다운로드 완료", type: .Registration)
          
          if image != UIImage() { // 이미지가 비어있지 않을 경우
            authorizationViewModel.showPhotoAlbum(selectImage: image) // 권한 확인
          }
        },
        ActionSheetCardItem(systemIconName: "calendar", label: "날짜 수정") {
          isUpdateDate = true
          isEllipsisClick = false
        },
        ActionSheetCardItem(systemIconName: "flag", label: "대표 사진") {
          listCellViewModel.putDelegate(albumId: albumId, fileId: info!.fileId)
          isEllipsisClick = false
          messageData2 = ToastMessage.MessageData(title: "대표 사진 등록", type: .Registration)
          isToastMessage = true
        },
        ActionSheetCardItem(systemIconName: "trash", label: "삭제", foregrounColor: Color(hex: "#EC407A")) {
          listCellViewModel.deleteFile(fileId: info!.fileId) // 파일 삭제
          messageData2 = ToastMessage.MessageData(title: "사진 제거", type: .Remove)
          isToastMessage = true

          presentable.wrappedValue.dismiss()
        }
      ]
    )
  }
  
  var actionSheetView2: some View {
    ActionSheetCard(
      isShowing: $isEllipsisClick,
      items: [
        ActionSheetCardItem(systemIconName: "arrow.down", label: "다운로드") {
          isEllipsisClick = false
          messageData2 = ToastMessage.MessageData(title: "다운로드 완료", type: .Registration)
          
          if image != UIImage() { // 이미지가 비어있지 않을 경우
            authorizationViewModel.showPhotoAlbum(selectImage: image) // 권한 확인
          }
        },
        ActionSheetCardItem(systemIconName: "calendar", label: "날짜 수정") {
          isUpdateDate = true
          isEllipsisClick = false
        },
        ActionSheetCardItem(systemIconName: "trash", label: "삭제", foregrounColor: Color(hex: "#EC407A")) {
          isEllipsisClick = false
          messageData2 = ToastMessage.MessageData(title: "사진 제거", type: .Remove)
          isToastMessage = true
          presentable.wrappedValue.dismiss()
        }
      ]
    )
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Button(action: {
          touchImage.toggle()
        }) {
          if image == UIImage() {
            Text("이미지를 불러오지 못했습니다")
              .foregroundColor(.white)
              .font(.custom("Pretendard-Medium", size: 16))
          } else { // 이미지가 비어있지 않을 경우
            Image(uiImage: image)
              .resizable()
              .scaledToFit()
              .pinchToZoom()
          }
        }
        
        Color.clear
          .ignoresSafeArea()
          .overlay(
            AlbumImageDetailNavigationBar(colorScheme: $colorScheme, safeTop: geometry.safeAreaInsets.top)
              .opacity(touchImage ? 0 : 1) // show/hidden toggle 기능
          )
          .overlay(
            AlbumImageDetailSettingBar(viewModel: AlbumDetailListCellViewModel(fileId: info!.fileId, isFavourite: info!.favourite), commentViewModel: commentViewModel, isBookmarkClick: $isBookmarkClick, isCommentClick: $isCommentClick, isEllipsisClick: $isEllipsisClick, info: info!)
              .opacity(touchImage ? 0 : 1) // show/hidden toggle 기능
          )
        
        if isCommentClick || isEllipsisClick { // 댓글 or action sheet
          Color.black
            .opacity(0.7)
            .ignoresSafeArea()
            .onTapGesture {
              isEllipsisClick = false
            }
          
          if isEllipsisClick {
            if isDate {
              actionSheetView // 바텀 Sheet
            } else {
              actionSheetView2 // 바텀 Sheet - 대표 사진 설정이 없음
            }
          }
        }
      }
      .background(Color.black)
      .ignoresSafeArea()
      .navigationBarHidden(true) // 이전 Navigation bar 무시
      .toastMessage(data: $messageData, isShow: $isBookmarkClick, topInset: geometry.safeAreaInsets.top)
      .toastMessage(data: $messageData2, isShow: $authorizationViewModel.showAlbum, topInset: geometry.safeAreaInsets.top)
      .toastMessage(data: $messageData2, isShow: $isToastMessage, topInset: geometry.safeAreaInsets.top)
      .fullScreenCover(isPresented: $isUpdateDate) { // 사진 & 녹음 수정
        AlbumDateEditView(fileId: info!.fileId) // 임시
      }
      .fullScreenCover(isPresented: $isCommentClick) {
        AlbumCommentView(viewModel: commentViewModel, isShowing: $isCommentClick, filedId: info!.fileId)
          .background(BackgroundCleanerView())
      }
      .alert(isPresented: $authorizationViewModel.showErrorAlert) {
        // 카메라 error
        Alert(
          title: Text(authorizationViewModel.showErrorAlertTitle),
          message: Text(authorizationViewModel.showErrorAlertMessage),
          primaryButton: .default(Text("설정")) { // 앱 설정으로 이동
            if let appSettring = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSettring, options: [:], completionHandler: nil)
            }
          },
          secondaryButton: .default(Text("확인")))
      }
      .onAppear {
        if isPreCommentClick { // Detail View에서 댓글 버튼을 눌렀을때
          isCommentClick = true
        }
      }
    }
  }
}

struct AlbumImageDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.results.elements[6]
    
    AlbumImageDetailView(commentViewModel: CommentViewModel(filedId: data.fileId), colorScheme: .constant(.dark), isDate: true, info: data, image: UIImage(named: data.link)!, albumId: 0, isPreCommentClick: false)
  }
}
