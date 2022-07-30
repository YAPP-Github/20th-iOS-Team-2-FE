//
//  AlbumDetailList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI
import Introspect

struct AlbumDetailList: View {
  @StateObject var viewModel: AlbumDetailListViewModel
  @StateObject var scrollViewHelper = ScrollViewHelper(threshold: 100)

  @Binding var isPhotoThumbnailClick: Bool
  @Binding var isRecordingThumbnailClick: Bool
  @Binding var selectFile: AlbumDetailElement?
  @Binding var selectImage: UIImage
  @Binding var isBookmarkClick: Bool
  @Binding var isPhotoCommentClick: Bool
  @Binding var isRecordingCommentClick: Bool
  @Binding var isEllipsisClick: Bool
  
  let selectAlbumId: Int?      // 날짜별
  let selectKindType: String?  // 유형별
  
  enum KindImage {
    case favourite
    case photo
    case recording
    case notCase
    
    var imageName: String {
      switch self {
      case .favourite: return "empty2"
      case .photo: return "empty3"
      case .recording: return "empty1"
      case .notCase: return ""
      }
    }
    
    var text: String {
      switch self {
      case .favourite: return "아직 즐겨찾기에 파일이 없습니다.\n즐겨찾기로 설정하고 여기서 모아보세요."
      case .photo: return "아직 업로드한 사진이 없습니다.\n사진을 업로드하고 여기서로 모아보세요."
      case .recording: return "아직 업로드한 음성이 없습니다.\n음성을 업로드하고 여기서로 모아보세요."
      case .notCase: return "아직 게시물이 없습니다.\n게시물을 업로드하고 여기서로 모아보세요."
      }
    }
  }
  
  func getKind(kind: String) -> KindImage {
    switch kind {
    case "favourite":
      return KindImage.favourite
    case "photo":
      return KindImage.photo
    case "recording":
      return KindImage.recording
    default:
      return KindImage.notCase
    }
  }
  
  var body: some View {
    ScrollView {
      PullToRefresh(coordinateSpaceName: "pullToRefresh") {
        if selectAlbumId != nil {
          viewModel.refreshActionSubjectByDate.send() // 날짜별
        } else if selectKindType != nil {
          viewModel.refreshActionSubjectByKind.send() // 유형별
        }
      }
      
      // 필요할때 rendering 함, network에 적합
      LazyVStack(spacing: 0) {
        ForEach(Array(zip(viewModel.albumDetailList.indices, viewModel.albumDetailList)), id: \.0) { index, element in
          AlbumDetailRow(viewModel: AlbumDetailListCellViewModel(fileId: element.fileId, isFavourite: element.favourite), listViewModel: viewModel, isPhotoThumbnailClick: $isPhotoThumbnailClick, isRecordingThumbnailClick: $isRecordingThumbnailClick, selectFile: $selectFile, selectImage: $selectImage, isBookmarkClick: $isBookmarkClick, isPhotoCommentClick: $isPhotoCommentClick, isRecordingCommentClick: $isRecordingCommentClick, isEllipsisClick: $isEllipsisClick, info: element, index: index)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
        
        if !viewModel.albumDetailList.isEmpty {
          Rectangle() // 마지막 게시물 밑
            .frame(height: 16)
            .foregroundColor(Color.white)
        }
      }
      .background(Color.white)
      
      if viewModel.albumDetailList.isEmpty {
        Image(getKind(kind: viewModel.type).imageName)
          .resizable()
          .scaledToFit()
          .padding(.top, 16)
          .padding([.leading, .trailing], 25)
        
        Text(getKind(kind: viewModel.type).text)
          .font(.custom("Pretendard-Medium", size: 18))
          .multilineTextAlignment(.center) // 가운데 정렬
          .lineSpacing(10)
          .foregroundColor(Color(hex: "999999"))
      }
    }
    .onAppear {
      if selectAlbumId != nil {
        viewModel.refreshActionSubjectByDate.send() // 날짜별 pagenation
      } else if selectKindType != nil {
        viewModel.refreshActionSubjectByKind.send() // 유형별 pagenation
      }
    }
    .offset(y: -10) // PullToRefresh로 인해 scrollview위로 올리기
    .background(Color.init(hex: "#FAF8F0")) // 임시
    .edgesIgnoringSafeArea(.bottom)
    .coordinateSpace(name: "pullToRefresh")
    .introspectScrollView(customize: { uiScrollView in
      uiScrollView.delegate = scrollViewHelper
    })
    .onReceive(self.scrollViewHelper.isBottom, perform: { isBottom in
      if selectAlbumId != nil {
        viewModel.fetchMoreActionSubjectByDate.send() // 날짜별 pagenation
      } else if selectKindType != nil {
        viewModel.fetchMoreActionSubjectByKind.send() // 유형별 pagenation
      }
    })
  }
}

struct AlbumDetailList_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.results.elements[3]
    
    AlbumDetailList(viewModel: AlbumDetailListViewModel(albumId: 0, kindType: ""), isPhotoThumbnailClick: .constant(false), isRecordingThumbnailClick: .constant(false), selectFile: .constant(data), selectImage: .constant(UIImage()), isBookmarkClick: .constant(false), isPhotoCommentClick: .constant(false), isRecordingCommentClick: .constant(false), isEllipsisClick: .constant(false), selectAlbumId: 0, selectKindType: "")
  }
}
