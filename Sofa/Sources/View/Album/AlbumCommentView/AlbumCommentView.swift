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
  @State var isEllipsisClick: Bool = false // 설정(수정, 삭제)
  @State var isEdit: Bool = false // 설정(수정)
  let filedId: Int
  
  var actionSheetView: some View {
    ActionSheetCard(
      isShowing: $isEllipsisClick,
      items: [
        ActionSheetCardItem(systemIconName: "pencil", label: "수정") {
          isEdit = true
          isEllipsisClick = false
        },
        ActionSheetCardItem(systemIconName: "trash", label: "삭제", foregrounColor: Color(hex: "#EC407A")) {
          isEllipsisClick = false
        }
      ]
    )
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      if isShowing {
        ModalBackGround { // Back Ground
          self.isShowing = false
        }
        
        CommentModal(viewModel: viewModel, isEllipsisClick: $isEllipsisClick, isEdit: $isEdit) { // 댓글 Modal
          self.isShowing = false
        }
        .transition(.move(edge: .bottom))
      }
      
      if isEllipsisClick { // action sheet
        Color.black
          .opacity(0.7)
          .ignoresSafeArea()
          .onTapGesture {
            isEllipsisClick = false
          }
        
        if isEllipsisClick {
          actionSheetView // 바텀 Sheet
        }
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
