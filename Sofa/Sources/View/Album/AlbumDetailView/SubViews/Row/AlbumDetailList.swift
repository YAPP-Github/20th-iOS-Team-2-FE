//
//  AlbumDetailList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI

struct AlbumDetailList: View {
  @ObservedObject var viewModel = AlbumDetailListViewModel()
  
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
      // 필요할때 rendering 함, network에 적합
      LazyVStack(spacing: 10) {
        ForEach(Array(zip(viewModel.albumDetailList.indices, viewModel.albumDetailList)), id: \.0) { index, element in
          AlbumDetailRow(isImageClick: $isImageClick, selectImage: $selectImage, selectImageIndex: $selectImageIndex, isBookmarkClick: $isBookmarkClick, isCommentClick: $isCommentClick, isEllipsisClick: $isEllipsisClick, info: element, index: index)

            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
      }
    }
    .onAppear {
      viewModel.fetch(albumId: selectAlbumId, kindType: selectKindType)
    }
  }
}

struct AlbumDetailList_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.elements[0]
    
    AlbumDetailList(isImageClick: .constant(false), selectImage: .constant(UIImage(named: data.link)!), selectImageIndex: .constant(0), isBookmarkClick: .constant(false), isCommentClick: .constant(false), isEllipsisClick: .constant(false), selectAlbumId: 0, selectKindType: "")
  }
}
