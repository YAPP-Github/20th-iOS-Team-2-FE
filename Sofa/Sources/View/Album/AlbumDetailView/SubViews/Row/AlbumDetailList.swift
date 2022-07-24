//
//  AlbumDetailList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI
import Introspect

struct AlbumDetailList: View {
  @ObservedObject var viewModel: AlbumDetailListViewModel
  @StateObject var scrollViewHelper = ScrollViewHelper(threshold: 100)

  // 이미지
  @Binding var isImageClick: Bool
  @Binding var selectImage: UIImage
  @Binding var selectImageIndex: Int

  @Binding var isBookmarkClick: Bool
  @Binding var isCommentClick: Bool
  @Binding var isEllipsisClick: Bool
  
  let selectAlbumId: Int?      // 날짜별
  let selectKindType: String?  // 유형별
  
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
          AlbumDetailRow(viewModel: AlbumDetailListCellViewModel(fileId: element.fileId, isFavourite: element.favourite), isImageClick: $isImageClick, selectImage: $selectImage, selectImageIndex: $selectImageIndex, isBookmarkClick: $isBookmarkClick, isCommentClick: $isCommentClick, isEllipsisClick: $isEllipsisClick, info: element, index: index)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
      }
      .background(Color.white)
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
    
    AlbumDetailList(viewModel: AlbumDetailListViewModel(albumId: 0, kindType: ""), isImageClick: .constant(false), selectImage: .constant(UIImage(named: data.link)!), selectImageIndex: .constant(0), isBookmarkClick: .constant(false), isCommentClick: .constant(false), isEllipsisClick: .constant(false), selectAlbumId: 0, selectKindType: "")
  }
}
