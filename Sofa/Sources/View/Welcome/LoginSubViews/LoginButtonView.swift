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
import AuthenticationServices
import SwiftKeychainWrapper

struct AppleUser: Codable {
  let userId: String
  let identityToken: String
  
  init?(credentials: ASAuthorizationAppleIDCredential){
    let identityToken = String(decoding: credentials.identityToken!, as: UTF8.self)
    
    self.userId = credentials.user
    self.identityToken = identityToken
  }
}

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
              Constant.accessToken = oauthToken!.accessToken
              Constant.refreshToken = oauthToken!.refreshToken
              
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
              Constant.accessToken = oauthToken!.accessToken
              Constant.refreshToken = oauthToken!.refreshToken
              
            }
          }
        }
        
      } label : {
        Image("SignInWithkakao")
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .padding(EdgeInsets(top: 0.04 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0, trailing: 0.075 * Screen.maxWidth))
      //      Button {
      //
      //
      //      } label : {
      //        Image("SignInWithApple")
      //          .resizable()
      //          .aspectRatio(contentMode: .fit)
      //
      //      }
      SignInWithAppleButton(
        .signIn,
        onRequest: configure,
        onCompletion: handle
      )
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
        let attributtedString = NSMutableAttributedString(string: myText, attributes: [NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 13)!, .paragraphStyle: paragraph])
        
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
  
  func configure(_ request: ASAuthorizationAppleIDRequest) {
    request.requestedScopes = []
  }
  
  func handle(_ authResult: Result<ASAuthorization, Error>) {
    switch authResult{
    case .success(let auth):
      print(auth)
      switch auth.credential{
      case let appleIDCredentials as ASAuthorizationAppleIDCredential:
        if let appleUser = AppleUser(credentials: appleIDCredentials),
          let appleUserData = try? JSONEncoder().encode(appleUser) {
            //            Constant.userID = appleUserData
            print(appleUser)
          }
        print(auth.credential)
      default:
        print(auth.credential)
      }
      
    case .failure(let error):
      print(error)
    }
  }
}

struct LoginButtonView_Previews: PreviewProvider {
  static var previews: some View {
    LoginButtonView()
  }
}
