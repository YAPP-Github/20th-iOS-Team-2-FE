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
    KakaoSDK.initSDK(appKey: "c1d24a892dad2a56e31fefcc5443a458")
    
  }
  var body: some Scene {
    WindowGroup {
      ContentView()
//      LoginView()
//        .onOpenURL { url in
//          if (AuthApi.isKakaoTalkLoginUrl(url)){
//            _ = AuthController.handleOpenUrl(url: url)
//          }
//        }
    }
  }
}
