//
//  AlbumRecordDetailView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/17.
//

import SwiftUI

struct AlbumRecordDetailView: View {
  @Environment(\.presentationMode) var presentable
  @ObservedObject private var audioViewModel = AudioRecorderViewModel(numberOfSamples: 21)
  @ObservedObject var favouriteViewModel: AlbumDetailListCellViewModel
  let info: AlbumDetailElement?
  
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
          audioViewModel.download(fileName: info!.title, link: info!.link) { complete in
            isToastMessage = complete
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
          messageData2 = ToastMessage.MessageData(title: "녹음 제거", type: .Remove)
          isToastMessage = true
          presentable.wrappedValue.dismiss()
        }
      ]
    )
  }
  
  // 녹음 Bar 영역
  var recordBarArea: some View {
    VStack(spacing: 8) {
      HStack(alignment: .center, spacing: 4) {
        ForEach(self.audioViewModel.soundSamples, id: \.self) { step in
          AudioBarView(color: Color(hex: "4CAF50"), isStep: step)
        }
      }
      
      ZStack { // 시간 영역
        Text("\(audioViewModel.minutes < 10 ? "0" : "")\(audioViewModel.minutes)" + " :")
          .offset(x: -35)
        Text("\(audioViewModel.seconds < 10 ? "0" : "")\(audioViewModel.seconds)" + " :")
        Text("\(audioViewModel.microSeconds < 10 ? "0" : "")\(audioViewModel.microSeconds)")
          .offset(x: 30)
      }
      .foregroundColor(Color.white)
      .font(.custom("Pretendard-Medium", size: 16))
      
    }
  }
  
  // 즐겨찾기, 댓글, 설정 영역
  var recordSettingArea: some View {
    HStack {
      Button(action: {
        // 북마크 네트워크 로직
        favouriteViewModel.postFavourite()
        if !favouriteViewModel.isFavourite { // 즐겨찾기 등록
          isBookmarkClick = true
        }
      }) {
        // 북마크
        Image(systemName: favouriteViewModel.isFavourite ? "bookmark.fill" : "bookmark")
          .frame(width: 20, height: 20)
          .foregroundColor(favouriteViewModel.isFavourite ? Color(hex: "#FFCA28") : .white)
          .font(.system(size: 20))
          .padding(.leading, 8)
      }
      
      Button(action: {
        // NetWork
        self.isCommentClick = true
      }, label: {
        HStack(spacing: 8) {
          Image(systemName: "ellipsis.bubble")
            .frame(width: 20, height: 20)
            .foregroundColor(.white)
            .font(.system(size: 20))
            .padding(.leading, 20)
          
          // 댓글 수
          Text("\(info!.commentCount)")
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(.white)
            .font(.system(size: 20))
        }
      })
      Spacer()
      Button(action: { // 설정
        self.isEllipsisClick = true
      }) {
        Image(systemName: "ellipsis")
          .frame(width: 20, height: 20)
          .foregroundColor(.white)
          .font(.system(size: 20))
      }
    }
    .padding(EdgeInsets(top: 12, leading: 12, bottom: 15, trailing: 16))
  }
  
  // 녹음 버튼 영역
  var recordButtonArea: some View {
    HStack(spacing: 68.5) {
      Button(action: {
        self.audioViewModel.jumpSeconds(seconds: -10.0)
      }) {
        Image(systemName: "gobackward.10")
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(Color(hex: "#FFFFFF").opacity(0.5))
      }
      Button(action: {
        if audioViewModel.isPlaying {
          self.audioViewModel.pausePlayback()
        } else {
          self.audioViewModel.startPlayback()
        }
      }, label: {
        ZStack {
          if audioViewModel.isPlaying { // 재생 중
            Circle()
              .frame(width: 64, height: 64)
              .foregroundColor(Color.white)
            
            Image(systemName: "pause.fill") // 정지
              .resizable()
              .frame(width: 28, height: 32)
              .foregroundColor(Color(hex: "D81B60"))
          } else { // 녹음 끝
            Circle()
              .frame(width: 64, height: 64)
              .foregroundColor(Color.white)
            
            Image(systemName: "play.fill") // 플레이
              .resizable()
              .frame(width: 29, height: 32)
              .foregroundColor(Color(hex: "D81B60"))
          }
        }
      })
      Button(action: {
        self.audioViewModel.jumpSeconds(seconds: 10.0)
      }) {
        Image(systemName: "goforward.10")
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(Color(hex: "#FFFFFF").opacity(0.5))
      }
    }
  }
  
  // 바텀 영역
  var recordBottomArea: some View {
    VStack {
      Spacer()
      VStack(spacing: 0) {
        recordSettingArea
        recordButtonArea
        Spacer()
      }
      .frame(width: Screen.maxWidth, height: Screen.maxWidth * 0.4)
      .background(Color(hex: "#161616").ignoresSafeArea(edges: .bottom))
    }
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        recordBarArea // 녹음 Bar 영역

        Color.clear
          .ignoresSafeArea()
          .overlay(
            // Navigation Bar
            AlbumRecordNavigationBar(isNext: .constant(false), existRecord: .constant(false), title: info!.title!, safeTop: geometry.safeAreaInsets.top)
          )
          .overlay(
            recordBottomArea
          )
        
        if isCommentClick || isEllipsisClick { // 댓글 or action sheet
          Color.black
            .opacity(0.7)
            .ignoresSafeArea()
            .onTapGesture {
              isEllipsisClick = false
            }
          
          if isEllipsisClick {
            actionSheetView // 설정 버튼 sheet
          }
        }
      }
      .background(Color.black)
      .ignoresSafeArea()
      .navigationBarHidden(true)
      .toastMessage(data: $messageData, isShow: $isBookmarkClick, topInset: geometry.safeAreaInsets.top)
      .toastMessage(data: $messageData2, isShow: $isToastMessage, topInset: geometry.safeAreaInsets.top)
      .fullScreenCover(isPresented: $isUpdateDate) { // 사진 & 녹음 수정
        AlbumDateEditView(fileId: info!.fileId) // 임시
      }
      .fullScreenCover(isPresented: $isCommentClick) {
        AlbumCommentView(isShowing: $isCommentClick, filedId: info!.fileId)
          .background(BackgroundCleanerView())
      }
      .onAppear {
        audioViewModel.startInit(audio: URL(string: info!.link)!)
        if isPreCommentClick { // Detail View에서 댓글 버튼을 눌렀을때
          isCommentClick = true
        }
      }
      .onDisappear {
        self.audioViewModel.stopInit()
      }
    }
  }
}

struct AlbumRecordDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.results.elements[3]
    
    AlbumRecordDetailView(favouriteViewModel: AlbumDetailListCellViewModel(fileId: data.fileId, isFavourite: data.favourite), info: data, isPreCommentClick: false)
  }
}
