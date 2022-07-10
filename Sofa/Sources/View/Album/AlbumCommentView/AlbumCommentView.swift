//
//  AlbumCommentView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/08.
//

import SwiftUI

struct AlbumCommentView: View {
  @Binding var isShowing: Bool

  var body: some View {
    if isShowing {
      ZStack(alignment: .bottom) {
        ModalBackGround { // Back Ground
          self.isShowing = false
        }
        
        CommentModal() // 댓글 Modal
          .transition(.move(edge: .bottom))
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      .ignoresSafeArea()
      .animation(.easeInOut)
    }
  }
}

struct AlbumCommentView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumCommentView(isShowing: .constant(true))
  }
}
