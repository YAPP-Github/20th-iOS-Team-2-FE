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
  let authorizationCode: String
  
  init?(credentials: ASAuthorizationAppleIDCredential){
    let identityToken = String(decoding: credentials.identityToken!, as: UTF8.self)
    let authorizationCode = String(decoding: credentials.authorizationCode!, as: UTF8.self)
    
    self.userId = credentials.user
    self.identityToken = identityToken
    self.authorizationCode = authorizationCode
  }
}

struct LoginButtonView: View {
  
  @StateObject var loginViewModel = LoginViewModel()
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
              print("👉accessToken: \(oauthToken!.accessToken)")
              print("👉refreshToken: \(oauthToken!.refreshToken)")
            
              self.loginViewModel.postKakaoLogin(accessToken: oauthToken!.accessToken, refreshToken: oauthToken!.refreshToken)

              
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
              print("👉accessToken: \(oauthToken!.accessToken)")
              print("👉refreshToken: \(oauthToken!.refreshToken)")
              
              
              self.loginViewModel.postKakaoLogin(accessToken: oauthToken!.accessToken, refreshToken: oauthToken!.refreshToken)
              

            }
          }
        }
        
      } label : {
        Image("SignInWithkakao")
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .frame(width: 326, height: 48, alignment: .center)
      .padding(EdgeInsets(top: 0.04 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0, trailing: 0.075 * Screen.maxWidth))

      SignInWithAppleButtonView(onRequest: configure(_:), onCompletion: handle(_:))
      .cornerRadius(40)
      .frame(width: 326, height: 48, alignment: .center)
      
      Image("line")
        .padding(EdgeInsets(top: 0.02 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0, trailing: 0.075 * Screen.maxWidth))
      
      VStack {
        TextLabelWithHyperlink()
      }
      .onAppear{
        
        // 여기에 써주세요!
//        KeychainWrapper.standard.set("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzpudWxsIiwiaWF0IjoxNjU3ODE1ODE2LCJleHAiOjE2NTc4MTk0MTZ9.AoThfTsgp4vzT4uVgl3llpGTmBPwzabjp-6t_2UjxAU", forKey: "accessToken")
        
      }
      .padding(EdgeInsets(top: 0.02 * Screen.maxHeight, leading: 0.075 * Screen.maxWidth, bottom: 0.05 * Screen.maxHeight, trailing: 0.075 * Screen.maxWidth))
      
    }//VStack
    .foregroundColor(Color.white)
    .background(Color.white)
    .frame(width: Screen.maxWidth, height: Screen.maxHeight * 0.4 , alignment: .center)
    .ignoresSafeArea()
    .background(Color.white )
    .fullScreenCover(isPresented: $loginViewModel.showJoin) { // 회원 등록
      RegisterView()
    }
    .fullScreenCover(isPresented: $loginViewModel.showContent) { // 재로그인
      ContentView()
    }
    
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

          print("authoriztionCode: \(appleUser.authorizationCode)")
          print("identityToken: \(appleUser.identityToken)")
          print("userID: \(appleUser.userId)")
          
          self.loginViewModel.postAppleLogin(identityToken: appleUser.identityToken, authoriztionCode: appleUser.authorizationCode, userId: appleUser.userId)
          
          }
//        print(auth.credential)
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
