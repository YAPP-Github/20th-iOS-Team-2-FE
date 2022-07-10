//
//  CommentModal.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/08.
//

import SwiftUI

struct CommentModal: View {
  @State private var curHeight: CGFloat = Screen.maxHeight / 2
  
  // Drag bar
  var topHalfMiddleBar: some View {
    Capsule()
      .frame(width: 48, height: 4)
      .foregroundColor(Color.black)
      .padding(.vertical, 8)
      .opacity(0.24)
  }
  
  var body: some View {
    VStack(alignment: .center) {
      topHalfMiddleBar // top bar
      
      AlbumCommentList()
      
      Divider()
        .overlay(Color(hex: "EDEADF"))
        .offset(x:0, y: 0)
    }
    .background(Color.white)
    .cornerRadius(15)
    .frame(height: curHeight)
    .frame(maxWidth: .infinity)
  }
}

struct CommentModal_Previews: PreviewProvider {
  static var previews: some View {
    ZStack(alignment: .bottom) {
      ModalBackGround() // Back Ground
      
      CommentModal() // 댓글 Modal
        .transition(.move(edge: .bottom))
    }
  }
}
