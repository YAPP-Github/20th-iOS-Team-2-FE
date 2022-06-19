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
  
  @State var titleShow = false
  @State var loginShow = false
  var body: some View {
    VStack(spacing: -120){
      Spacer()
      Spacer()
      if titleShow{
        VStack{
          Text("우리 가족만의 공간")
            .font(.system(size: 28))
          Text("Sofa")
            .font(.system(size: 32))
        }
        .animation(.easeInOut(duration: 1))
        .transition(.move(edge: .top))
        .foregroundColor(Color(hex: "FAF8F0"))
        .onAppear{
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 1초 후 Login Show
            self.loginShow = true
          }
        }
      }else{
        VStack{
          Text("우리 가족만의 공간")
            .font(.system(size: 28))
          Text("Sofa")
            .font(.system(size: 32))
        }
        .animation(.default)
        .transition(.move(edge: .top))
        .foregroundColor(Color(hex: "FAF8F0"))
        .opacity(0)
      }
      LottieView(filename: "15025-bed")
        .frame(width: UIScreen.main.bounds.width, height: 400)
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
    .background(Color(hex: "29662C"))
    .ignoresSafeArea()
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 3초 후 Title Show
        self.titleShow = true
      }
    }
  }
  
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}


