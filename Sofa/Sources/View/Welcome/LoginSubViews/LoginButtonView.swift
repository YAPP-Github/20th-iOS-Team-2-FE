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
import SwiftKeychainWrapper

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

              // Keychain에 User Token 저장
              KeychainWrapper.standard.set(oauthToken!.accessToken, forKey: "userAccessToken")
              KeychainWrapper.standard.set(oauthToken!.refreshToken, forKey: "userRefreshToken")
              
//              let userAccessToken: String? = KeychainWrapper.standard.string(forKey: "userAccessToken")
//              print(userAccessToken ?? "Token is nil")
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

              // Keychain에 User Token 저장
              KeychainWrapper.standard.set(oauthToken!.accessToken, forKey: "userAccessToken")
              KeychainWrapper.standard.set(oauthToken!.refreshToken, forKey: "userRefreshToken")
              
              let userAccessToken: String? = KeychainWrapper.standard.string(forKey: "userAccessToken")
              print(userAccessToken ?? "Token is nil")
              
            }
          }
        }
        
      } label : {
        Image("SignInWithkakao")
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .padding(EdgeInsets(top: 0.04 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0, trailing: 0.075 * Screen.maxWidth))
      Button {
        
        
      } label : {
        Image("SignInWithApple")
          .resizable()
          .aspectRatio(contentMode: .fit)
        
      }
      .padding(EdgeInsets(top: 0.02 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0.025 * Screen.maxHeight, trailing: 0.075 * Screen.maxWidth))
      Image("line")
        .padding(EdgeInsets(top: 0.02 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0.025 * Screen.maxHeight, trailing: 0.075 * Screen.maxWidth))
      
      // 폰트 Color 확정 X
      Group() {
        Text("‘시작하기'를 누르는 것으로 ").foregroundColor(Color.gray)
        + Text("필수 이용약관").foregroundColor(Color(hex: "50AD50"))
        + Text(" 및 ").foregroundColor(Color.gray)
        + Text("개인").foregroundColor(Color(hex: "50AD50")) + Text("정보 ").foregroundColor(Color(hex: "50AD50"))
        + Text("이용방침").foregroundColor(Color(hex: "50AD50"))
        + Text("에 동의하고 서비스를 이용합니다.").foregroundColor(Color.gray)
      }
      .padding(EdgeInsets(top: 0, leading: 0.075 * Screen.maxWidth, bottom: 0.06 * Screen.maxHeight, trailing: 0.075 * Screen.maxWidth))
      
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
