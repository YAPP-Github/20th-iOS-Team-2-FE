//
//  Constants.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI
import SwiftKeychainWrapper

class Constant{

  static var accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken") {
    didSet {
      guard let token = accessToken else { return }
      print("ACCESS TOKEN: \(token)")
      KeychainWrapper.standard.set(token, forKey: "accessToken")
    }
  }

}

struct Screen {
  static let maxWidth = UIScreen.main.bounds.width
  static let maxHeight = UIScreen.main.bounds.height
  
  static var safeAreaTop: CGFloat {
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .map({$0 as? UIWindowScene})
      .compactMap({$0})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    
    return (keyWindow?.safeAreaInsets.top)!
  }
  
  static var safeAreaBottom: CGFloat {
    let keyWindow = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .map({$0 as? UIWindowScene})
      .compactMap({$0})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    
    return (keyWindow?.safeAreaInsets.bottom)!
  }
}
