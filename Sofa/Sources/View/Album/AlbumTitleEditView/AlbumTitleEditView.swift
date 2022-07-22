//
//  AlbumTitleEditView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/15.
//

import SwiftUI
import UIKit

struct AlbumTitleEditView: View {
  @StateObject var keyboardHeightHelper = KeyboardHeightHelper()
  @State var title: String
  @State var isTextView = false
  @State var isLimite = false
  @State var messageData: ToastMessage.MessageData = ToastMessage.MessageData(title: "글자는 20자까지 입력가능합니다", type: .Remove)
  @Binding var isShowing: Bool
  let duration = 0.5
  let textLimit: Int = 20

  var completeButton: some View {
    VStack {
      Button(action: {
        self.isTextView = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
          // isTextView가 닫히고
          self.isShowing = false
        }
      }) {
        Text("완료")
          .foregroundColor(Color.white)
          .font(.custom("Pretendard-Bold", size: 18))
          .frame(maxWidth: .infinity, minHeight: 48)
          .background(Color(hex: title.isEmpty ? "#A8A8A8" : "#43A047")) // 임시
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .padding(.top, 8)
      }
      .disabled(title.isEmpty)
      Spacer()
    }
    .padding(.horizontal, 16)
    .frame(width: Screen.maxWidth, height: 64)
    .background(Color.white)
    .offset(y: -keyboardHeightHelper.keyboardWillShowHeight)
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottom) {
        ModalBackGround { // Back Ground
          self.isTextView = false
          DispatchQueue.main.asyncAfter(deadline: .now() + duration/2) {
            // isTextView가 닫히고
            self.isShowing = false
          }
        }
        
        if isTextView { // 0.5초 후 Show
          AlbumTitleEditNavigationBar(title: $title, isLimite: $isLimite, safeTop: geometry.safeAreaInsets.top, textLimit: textLimit)
            .transition(.move(edge: .top))
            .animation(.easeInOut(duration: duration/2))
          
          completeButton
            .transition(.move(edge: .bottom))
            .animation(.easeInOut(duration: duration/2))
        }
      }
      .toastMessage(data: $messageData, isShow: $isLimite, topInset: Screen.safeAreaTop + 65)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      .ignoresSafeArea()
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
          // 0.5초 후 isTextView Show
          self.isTextView = true
        }
      }
    }
  }
}

struct AlbumTitleEditView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.black
        .opacity(0.7)
        .ignoresSafeArea()
      
      AlbumTitleEditView(title: "2022-07-13 앨범", isShowing: .constant(true))
    }
  }
}
