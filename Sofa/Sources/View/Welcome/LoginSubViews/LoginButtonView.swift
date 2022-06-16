//
//  LoginButtonView.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/14.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

struct LoginButtonView: View {
  var body: some View {
    VStack{
      Button {
        if (UserApi.isKakaoTalkLoginAvailable()) {// 카톡이 설치되어있다면
          UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
              print("👇 error 👇")
              print(error)
            }
            else {
              print("loginWithKakaoTalk() success.")
              print("👇 oauthToken?.accessToken 👇")
              print(oauthToken?.accessToken)
              print("👇 oauthToken?.refreshToken 👇")
              print(oauthToken?.refreshToken)
            

            }
          }
        } else { // 카톡이 설치되어있지 않다면
          UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error { 
              print("👇 error 👇")
              print(error)
            }
            else {
              print("loginWithKakaoTalk() success.")
              print("👇 oauthToken?.accessToken 👇")
              print(oauthToken?.accessToken)
              print("👇 oauthToken?.refreshToken 👇")
              print(oauthToken?.refreshToken)

            }
          }
        }
        
      } label : {
        Image("SignInWithkakao")
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .padding(EdgeInsets(top: 32, leading: 30, bottom: 0, trailing: 30))
      Button {
        
        
      } label : {
        Image("SignInWithApple")
          .resizable()
          .aspectRatio(contentMode: .fit)
        
      }
      .padding(EdgeInsets(top: 16, leading: 30, bottom: 20, trailing: 30))
      Image("line")
        .padding(EdgeInsets(top: 16, leading: 30, bottom: 20, trailing: 30))
      
      // 폰트 Color 확정 X
      Group() {
        Text("‘시작하기'를 누르는 것으로 ").foregroundColor(Color.gray)
        + Text("필수 이용약관").foregroundColor(Color(hex: "50AD50"))
        + Text(" 및 ").foregroundColor(Color.gray)
        + Text("개인").foregroundColor(Color(hex: "50AD50")) + Text("정보 ").foregroundColor(Color(hex: "50AD50"))
        + Text("이용방침").foregroundColor(Color(hex: "50AD50"))
        + Text("에 동의하고 서비스를 이용합니다.").foregroundColor(Color.gray)
      }
      .padding(EdgeInsets(top: 0, leading: 30, bottom: 55, trailing: 30))
      
    }//VStack
    .ignoresSafeArea()
    .background(Color.white)
    
  }
}

struct LoginButtonView_Previews: PreviewProvider {
  static var previews: some View {
    LoginButtonView()
  }
}
