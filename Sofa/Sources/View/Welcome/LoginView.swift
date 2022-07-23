//
//  LoginView.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/04.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth

struct LoginView: View {

  @State var loginShow = false
  var body: some View {
    ZStack{
      LottieView(filename: "113766-gravity")
        .frame(width: Screen.maxWidth, height: Screen.maxHeight)
      VStack(spacing: -120){
        Spacer()
        if loginShow{
          LoginButtonView()
            .padding(.bottom, UIDevice().hasNotch ? 5 : 0)
            .background(Color.white)
            .cornerRadius(25, corners: [.topLeft, .topRight])
            .animation(.easeInOut(duration: 1))
            .transition(.move(edge: .bottom))
        }else{
          LoginButtonView()
            .cornerRadius(25, corners: [.topLeft, .topRight])
            .opacity(0)
            .padding(.bottom, UIDevice().hasNotch ? 5 : 0)
        }
      }//VStack
      .ignoresSafeArea()
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          self.loginShow = true
        }
      }
    }//ZStack
    .background(Color.black)
    .ignoresSafeArea()
  }
  
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}


