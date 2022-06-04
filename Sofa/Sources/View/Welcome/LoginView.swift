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
  var body: some View {
    Button {
      if (UserApi.isKakaoTalkLoginAvailable()) {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
          if let error = error {
            print(error)
          }
          else {
            print("loginWithKakaoTalk() success.")
            
            //do something
            print(oauthToken)
          }
        }
      } else {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
          if let error = error {
            print(error)
          }
          else {
            print("loginWithKakaoTalk() success.")
            
            //do something
            print(oauthToken)
          }
        }
      }
    } label : {
      Image("kakao_login_medium_narrow")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width : UIScreen.main.bounds.width * 0.5)
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
