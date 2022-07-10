//
//  AlbumCommentList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/10.
//

import SwiftUI

struct AlbumCommentList: View {
  @ObservedObject var viewModel = CommentViewModel()

  var body: some View {
    ScrollView {
      // 필요할때 rendering 함, network에 적합
      LazyVStack(spacing: 0) {
        ForEach(Array(zip(viewModel.comments.indices, viewModel.comments)), id: \.0) { index, element in
          AlbumCommentRow(comment: element)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            .animationsDisabled()
        }
      }
    }
    .onAppear {
      self.viewModel.fetchComment()
    }
  }
}

struct AlbumCommentList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumCommentList()
  }
}
