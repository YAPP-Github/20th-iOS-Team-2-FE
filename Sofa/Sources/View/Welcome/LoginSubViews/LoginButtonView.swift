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
  @State var text: NSMutableAttributedString = NSMutableAttributedString(string: "")
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
      .padding(EdgeInsets(top: 0.02 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0, trailing: 0.075 * Screen.maxWidth))
      Image("line")
        .padding(EdgeInsets(top: 0.02 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0, trailing: 0.075 * Screen.maxWidth))
      
      VStack {
        CustomText(text: self.$text)
      }
      .onAppear{
        let myText = "'시작하기'를 누른 것으로 필수 이용약관 및 개인정보 이용방침에 동의하고 서비스를 이용합니다."
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributtedString = NSMutableAttributedString(string: myText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), .paragraphStyle: paragraph])

        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: "#999899"), range: (myText as NSString).range(of: myText))
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: "#439F47"), range: (myText as NSString).range(of: "필수 이용약관"))
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: "#439F47"), range: (myText as NSString).range(of: "개인정보 이용방침"))
        
        
        self.text = attributtedString
        
      }
      .padding(EdgeInsets(top: 0.02 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0.05 * Screen.maxHeight, trailing: 0.075 * Screen.maxWidth))
      
    }//VStack
    .frame(width: Screen.maxWidth, height: Screen.maxHeight * 0.4 , alignment: .center)
    .ignoresSafeArea()
    .background(Color.white)
    
  }
}

struct LoginButtonView_Previews: PreviewProvider {
  static var previews: some View {
    LoginButtonView()
  }
}
