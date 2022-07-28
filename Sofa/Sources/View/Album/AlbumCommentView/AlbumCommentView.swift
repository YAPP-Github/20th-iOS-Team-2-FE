//
//  AlbumCommentView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/08.
//

import SwiftUI

struct AlbumCommentView: View {
  @StateObject var viewModel: CommentViewModel
  @Binding var isShowing: Bool
  let filedId: Int
  
  var body: some View {
    ZStack(alignment: .bottom) {
      if isShowing {
        ModalBackGround { // Back Ground
          self.isShowing = false
        }
        
        CommentModal(viewModel: viewModel) { // 댓글 Modal
          self.isShowing = false
        }
        .transition(.move(edge: .bottom))
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .ignoresSafeArea()
    .animation(.easeInOut)
  }
}

struct AlbumCommentView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumCommentView(viewModel: CommentViewModel(filedId: 0), isShowing: .constant(true), filedId: 0)
  }
}
