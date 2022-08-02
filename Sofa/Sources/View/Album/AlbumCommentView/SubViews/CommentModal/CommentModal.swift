//
//  CommentModal.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/08.
//

import SwiftUI

struct CommentModal: View {
  @StateObject var viewModel: CommentViewModel
  @State private var curHeight: CGFloat = Screen.maxHeight / 2
  @State private var prevDragTranslation = CGSize.zero
  @State private var isDragging = false
  @State var isWriteClick = false
  @State var commentText: String?
  @State var placeholder = "댓글을 남겨보세요"
  @State var selectComment: Comment?
  @State var editText: String?
  @Binding var isEllipsisClick: Bool // 설정(수정, 삭제)
  @Binding var isEdit: Bool // 설정(수정)
  let minHeight: CGFloat = Screen.maxHeight / 2
  let maxHeight: CGFloat = Screen.maxHeight * 0.9
  var callback: (() -> ())? = nil
    
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
    .gesture(dragGesture)
  }
  
  var dragGesture: some Gesture {
    DragGesture(minimumDistance: 0, coordinateSpace: .global)
      .onChanged { value in
        isDragging = true
        
        let dragAmount = value.translation.height - prevDragTranslation.height
        
        if curHeight > maxHeight || curHeight < minHeight {
          curHeight -= dragAmount / 6
        } else{
          curHeight -= dragAmount
        }
        
        prevDragTranslation = value.translation
      }
      .onEnded { _ in
        prevDragTranslation = .zero
        isDragging = false
        if curHeight > minHeight + 35 {
          curHeight = maxHeight
        } else if curHeight < minHeight - 35 {
          callback?() // 닫기
          curHeight = minHeight
        } else{
          curHeight = minHeight
        }
      }
  }
  
  var CommentInput: some View {
    HStack {
      Text("댓글을 남겨보세요")
        .font(.custom("Pretendard-Medium", size: 16))
        .foregroundColor(Color(hex: "999999"))
        .padding(EdgeInsets(top: 16, leading: 26, bottom: 12, trailing: 26))
      
      Spacer()
    }
    .frame(height: 52)
    .onTapGesture {
      isWriteClick = true
    }
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      topHalfMiddleBar // top bar
      
      AlbumCommentList(viewModel: viewModel, selectComment: $selectComment, editText: $editText, isEllipsisClick: $isEllipsisClick)
      
      Divider()
        .overlay(Color(hex: "EDEADF"))
        .offset(x:0, y: 0)
      
      CommentInput // 댓글 입력창
      
      Spacer()
        .frame(height: Screen.safeAreaBottom)
    }
    .fullScreenCover(isPresented: $isWriteClick) {
      MessageView($isWriteClick, $commentText, 0, $placeholder) {
        if let commentText = commentText {
          self.viewModel.writeComment(content: commentText) // 댓글 전송
          self.commentText = nil // 댓글 초기화
        }
      }
      .background(BackgroundCleanerView())
    }
    .fullScreenCover(isPresented: $isEdit) { // 댓글 수정
      MessageView($isEdit, $editText, editText == nil ? 0 : editText!.count, $placeholder) {
        if let editText = editText {
          self.viewModel.editComment(commentId: selectComment!.commentId, content: editText) // 댓글 수정
          self.editText = nil // 댓글 초기화
        }
      }
      .background(BackgroundCleanerView())
    }
    .background(Color.white)
    .cornerRadius(16)
    .frame(height: isWriteClick || isEdit ? 0 : curHeight) // 댓글 View가 나타날때
    .frame(maxWidth: .infinity)
    .animation(isDragging ? nil : .easeInOut(duration: 0.45))
  }
}

struct CommentModal_Previews: PreviewProvider {
  static var previews: some View {
    ZStack(alignment: .bottom) {
      ModalBackGround() // Back Ground
      
      CommentModal(viewModel: CommentViewModel(filedId: 0), isEllipsisClick: .constant(false), isEdit: .constant(false)) // 댓글 Modal
        .transition(.move(edge: .bottom))
    }
  }
}
