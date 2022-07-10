//
//  SofaApp.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/04.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct SofaApp: App {
  init(){
    let KAKAO_APP_KEY: String = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String ?? "KAKAO_APP_KEY is nil"
    KakaoSDK.initSDK(appKey: KAKAO_APP_KEY)
  }
  var body: some Scene {
    WindowGroup {
//      ContentView()
//      LoginView()
//        .onOpenURL { url in
//          if (AuthApi.isKakaoTalkLoginUrl(url)){
//            _ = AuthController.handleOpenUrl(url: url)
//          }
//        }
      MessageView(.constant(true))
    }
  }
}
