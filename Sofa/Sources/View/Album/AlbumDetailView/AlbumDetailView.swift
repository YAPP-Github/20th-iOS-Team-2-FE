//
//  AlbumDetailView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import SwiftUI
import URLImage

struct AlbumDetailView: View {
  @Environment(\.presentationMode) var presentable
  @ObservedObject var tabbarManager = TabBarManager.shared
  @ObservedObject var authorizationViewModel = AuthorizationViewModel()
  @ObservedObject var audioViewModel = AudioRecorderViewModel(numberOfSamples: 21)
  
  @State var isTitleClick = false
  @State var isEdit = false
  
  // 이미지
  @State var isPhotoThumbnailClick: Bool = false
  @State var isRecordingThumbnailClick: Bool = false
  @State var selectFile: AlbumDetailElement?
  @State var selectImage: UIImage = UIImage()
  
  // 즐겨찾기
  @State var isBookmarkClick: Bool = false
  @State var messageData: ToastMessage.MessageData = ToastMessage.MessageData(title: "즐겨찾기 등록", type: .Registration)
  
  @State var isPhotoCommentClick: Bool = false   // 사진 댓글
  @State var isRecordingCommentClick: Bool = false   // 녹음 댓글
  
  @State var isEllipsisClick: Bool = false  // 사진 설정
  
  // Toast Message
  @State var isToastMessage: Bool = false
  @State var messageData2: ToastMessage.MessageData = ToastMessage.MessageData(title: "다운로드 완료", type: .Registration)
  
  @State var isUpdateDate: Bool = false  // 사진 & 녹음 날짜 수정
  @State var title: String
  var selectAlbumId: Int?      // 날짜별
  var selectKindType: String?  // 유형별
  
  var actionSheetView: some View {
    ActionSheetCard(
      isShowing: $isEllipsisClick,
      items: [
        ActionSheetCardItem(systemIconName: "arrow.down", label: "다운로드") {
          isEllipsisClick = false
          messageData2 = ToastMessage.MessageData(title: "다운로드 완료", type: .Registration)
          
          if selectFile?.kind == "PHOTO" {
            authorizationViewModel.showPhotoAlbum(selectImage: selectImage) // 권한 확인
          } else if selectFile?.kind == "RECORDING" {
            audioViewModel.download(fileName: selectFile?.title, link: selectFile!.link) { complete in
              isToastMessage = complete
            }
          }
        },
        ActionSheetCardItem(systemIconName: "calendar", label: "날짜 수정") {
          isUpdateDate = true
          isEllipsisClick = false
        },
        ActionSheetCardItem(systemIconName: "flag", label: "대표 사진") {
          isEllipsisClick = false
          messageData2 = ToastMessage.MessageData(title: "대표 사진 등록", type: .Registration)
          isToastMessage = true
        },
        ActionSheetCardItem(systemIconName: "trash", label: "삭제", foregrounColor: Color(hex: "#EC407A")) {
          isEllipsisClick = false
        }
      ]
    )
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        ZStack {
          AlbumDetailList(viewModel: AlbumDetailListViewModel(albumId: selectAlbumId, kindType: selectKindType), isPhotoThumbnailClick: $isPhotoThumbnailClick, isRecordingThumbnailClick: $isRecordingThumbnailClick, selectFile: $selectFile, selectImage: $selectImage, isBookmarkClick: $isBookmarkClick, isPhotoCommentClick: $isPhotoCommentClick, isRecordingCommentClick: $isRecordingCommentClick, isEllipsisClick: $isEllipsisClick, selectAlbumId: selectAlbumId, selectKindType: selectKindType)
          
          // 이미지 click
          NavigationLink("", destination: AlbumImageDetailView(info: selectFile, image: selectImage, isPreCommentClick: false), isActive: $isPhotoThumbnailClick)
          
          // 댓글 click
          NavigationLink("", destination: AlbumImageDetailView(info: selectFile, image: selectImage, isPreCommentClick: true), isActive: $isPhotoCommentClick)
          
          // 녹음 이미지 click
          NavigationLink("", destination: AlbumRecordDetailView(info: selectFile, isPreCommentClick: false), isActive: $isRecordingThumbnailClick)
          
          // 댓글 click
          NavigationLink("", destination: AlbumRecordDetailView(info: selectFile, isPreCommentClick: true), isActive: $isRecordingCommentClick)
        }
        .toastMessage(data: $messageData, isShow: $isBookmarkClick, topInset: 0)
        .toastMessage(data: $messageData2, isShow: $authorizationViewModel.showAlbum, topInset: 0)
        .toastMessage(data: $messageData2, isShow: $isToastMessage, topInset: 0)
        .navigationBarWithTextButtonStyle(isNextClick: $isEdit, isTitleClick: $isTitleClick, isDisalbeNextButton: selectAlbumId != nil ? .constant(false) : .constant(true), isDisalbeTitleButton: selectAlbumId != nil ? .constant(false) : .constant(true), title, nextText: "편집", Color.init(hex: "#43A047"))
        .fullScreenCover(isPresented: $isEdit) { // 앨범 날짜 수정
          AlbumDateEditView(parant: self, albumId: selectAlbumId) // 임시
        }
        .fullScreenCover(isPresented: $isUpdateDate) { // 사진 & 녹음 수정
          AlbumDateEditView(fileId: selectFile!.fileId) // 임시
        }
        .fullScreenCover(isPresented: $isTitleClick) {
          AlbumTitleEditView(title: title, isShowing: $isTitleClick, preTitle: $title, albumId: selectAlbumId!)
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
        .edgesIgnoringSafeArea([.bottom]) // Bottom만 safeArea 무시
      }
      .navigationBarHidden(true)
      .onDisappear{
        UITabBar.showTabBar(animated: false)
        tabbarManager.showTabBar = true
      }
      .onAppear{
        UITabBar.showTabBar(animated: false)
        tabbarManager.showTabBar = false
      }
      
      if isEllipsisClick || isTitleClick { // action sheet
        Color.black
          .opacity(0.7)
          .ignoresSafeArea()
          .onTapGesture {
            isEllipsisClick = false
          }
        
        if isEllipsisClick {
          actionSheetView // 바텀 Sheet
        }
      }
    }
  }
}

struct AlbumDetailView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDetailView(title: "앨범 상세", selectAlbumId: 0, selectKindType: "")
  }
}
