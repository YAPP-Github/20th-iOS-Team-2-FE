//
//  AlbumImageDetailSettingBar.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/07.
//

import SwiftUI

struct AlbumImageDetailSettingBar: View {
  @ObservedObject var viewModel: AlbumDetailListCellViewModel

  @Binding var isBookmarkClick: Bool
  @Binding var isCommentClick: Bool
  @Binding var isEllipsisClick: Bool

  var info: AlbumDetailElement // 임시 @ObservedObject로 변경해야함
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
        VStack {
          HStack {
            Button(action: {
              // 북마크 네트워크 로직
              viewModel.postFavourite()
              if !viewModel.isFavourite { // 즐겨찾기 해제
                isBookmarkClick = true
              }
            }) {
              // 북마크
              Image(systemName: viewModel.isFavourite ? "bookmark.fill" : "bookmark")
                .frame(width: 20, height: 20)
                .foregroundColor(viewModel.isFavourite ? Color(hex: "#FFCA28") : .white)
                .font(.system(size: 20))
                .padding(.leading, 8)
            }
            
            Button(action: {
              // NetWork
              isCommentClick = true
            }, label: {
              HStack(spacing: 8) {
                Image(systemName: "ellipsis.bubble")
                  .frame(width: 20, height: 20)
                  .foregroundColor(.white)
                  .font(.system(size: 20))
                  .padding(.leading, 20)
                
                // 댓글 수
                Text("\(info.commentCount)")
                  .foregroundColor(.white)
                  .font(.custom("Pretendard-Medium", size: 20))
              }
            })
            
            Spacer()
            
            Button(action: {
              isEllipsisClick = true
            }) {
              Image(systemName: "ellipsis")
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .font(.system(size: 20))
            }
          }
          .padding(EdgeInsets(top: 12, leading: 12, bottom: 15, trailing: 16))
          Spacer()
        }
        .frame(height: 83)
        .background(Blur(style: .systemUltraThinMaterial).ignoresSafeArea(edges: .bottom))
      }
    }
  }
}

struct AlbumImageDetailSettingBar_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.results.elements[3]
    
    AlbumImageDetailSettingBar(viewModel: AlbumDetailListCellViewModel(fileId: 0, isFavourite: false), isBookmarkClick: .constant(false), isCommentClick: .constant(false), isEllipsisClick: .constant(false), info: data)
      .ignoresSafeArea()
  }
}
