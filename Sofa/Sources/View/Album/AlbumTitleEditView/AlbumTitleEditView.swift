//
//  AlbumTitleEditView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/15.
//

import SwiftUI

struct AlbumTitleEditView: View {
  @StateObject var keyboardHeightHelper = KeyboardHeightHelper()
  let duration = 0.5
    .offset(y: -keyboardHeightHelper.keyboardWillShowHeight)
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
          DispatchQueue.main.asyncAfter(deadline: .now() + duration/2) {
            // isTextView가 닫히고
            self.isShowing = false
          }
            .transition(.move(edge: .top))
            .animation(.easeInOut(duration: duration/2))
            .transition(.move(edge: .bottom))
            .animation(.easeInOut(duration: duration/2))
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
          // 0.5초 후 isTextView Show
          self.isTextView = true
        }
      }
  }
}

struct AlbumTitleEditView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumTitleEditView()
  }
}
