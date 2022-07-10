//
//  CommentModal.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/08.
//

import SwiftUI

struct CommentModal: View {
  @State private var curHeight: CGFloat = Screen.maxHeight / 2
  
  
  var body: some View {
    VStack(alignment: .center) {
    }
    .background(Color.white)
    .cornerRadius(15)
    .frame(height: curHeight)
    .frame(maxWidth: .infinity)
  }
}

struct CommentModal_Previews: PreviewProvider {
  static var previews: some View {
      CommentModal() // 댓글 Modal
  }
}
