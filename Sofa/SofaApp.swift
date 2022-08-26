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

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
  }
}

@main
struct SofaApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  init(){
    let KAKAO_APP_KEY: String = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String ?? "KAKAO_APP_KEY is nil"
    KakaoSDK.initSDK(appKey: KAKAO_APP_KEY)
    
    if Storage.isFirstTime() { // 첫 실행
      Constant.accessToken = nil
      KeychainWrapper.standard.remove(forKey: "accessToken")
      Constant.userId = nil
      KeychainWrapper.standard.remove(forKey: "userId")
    }
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
      
      ContentView()
    }
  }
}
