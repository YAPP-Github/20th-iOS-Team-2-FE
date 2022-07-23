//
//  SofaApp.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/04.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import SwiftKeychainWrapper

@main
struct SofaApp: App {
  init(){
    let KAKAO_APP_KEY: String = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String ?? "KAKAO_APP_KEY is nil"
    KakaoSDK.initSDK(appKey: KAKAO_APP_KEY)
  }
  var body: some Scene {
    WindowGroup {
      
//      if KeychainWrapper.standard.string(forKey: "accessToken") != nil{ // Access Token 있다면, 홈 화면
//        ContentView()
//      }
//      else{ // 로그인 필요
//        LoginView()
//          .onOpenURL { url in
//            if (AuthApi.isKakaoTalkLoginUrl(url)){
//              _ = AuthController.handleOpenUrl(url: url)
//            }
//          }
//      }
      
      LoginView()

    }
  }
}
