//
//  AlbumCommentList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/10.
//

import SwiftUI

struct AlbumCommentList: View {
  @StateObject var viewModel: CommentViewModel

  var body: some View {
    ScrollView {
      // 필요할때 rendering 함, network에 적합
      LazyVStack(spacing: 0) {
        ForEach(Array(zip(viewModel.comments.indices, viewModel.comments)), id: \.0) { index, element in
          AlbumCommentRow(comment: element)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            .animationsDisabled()
        }
        
        // 댓글이 없을 경우
        if viewModel.comments.count == 0 {
          VStack(spacing: 10) {
            Text("아직 댓글이 없습니다") // 별명
              .font(.custom("Pretendard-Bold", size: 16))
            Text("말을 걸어 대화를 시작해보세요") // 별명
              .font(.custom("Pretendard-Medium", size: 16))
          }
          .foregroundColor(Color.black)
        }
      }
    }
  }
}

struct AlbumCommentList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumCommentList(viewModel: CommentViewModel(filedId: 0))
  }
}
