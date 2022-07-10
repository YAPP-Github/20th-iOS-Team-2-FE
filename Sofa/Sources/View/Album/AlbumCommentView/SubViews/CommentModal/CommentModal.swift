//
//  CommentModal.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/08.
//

import SwiftUI

struct CommentModal: View {
  @State private var curHeight: CGFloat = Screen.maxHeight / 2
  @State var isWriteClick = false
  
  // Drag bar
  var topHalfMiddleBar: some View {
    VStack {
      Capsule()
        .frame(width: 48, height: 4)
        .foregroundColor(Color.black)
        .opacity(0.24)
        .padding(.top, 8)
      
      Spacer()
    }
    .frame(height: 40)
    .frame(maxWidth: .infinity)
    .background(Color.white) // 색상을 줘야 frame 영역 gesture 작동
  }
  var CommentInput: some View {
    HStack {
      Text("댓글을 남겨보세요")
        .font(.custom("Pretendard-Medium", size: 16))
        .foregroundColor(Color.secondary)
        .padding(EdgeInsets(top: 16, leading: 26, bottom: 12, trailing: 26))
      
      Spacer()
    }
    .frame(height: 52)
    .onTapGesture {
      isWriteClick = true
    }
  }
  
  var body: some View {
    VStack(alignment: .center) {
      topHalfMiddleBar // top bar
      
      AlbumCommentList()
      
      Divider()
        .overlay(Color(hex: "EDEADF"))
        .offset(x:0, y: 0)
      
      CommentInput // 댓글 입력창
      
      Spacer()
        .frame(height: Screen.safeAreaBottom)
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
