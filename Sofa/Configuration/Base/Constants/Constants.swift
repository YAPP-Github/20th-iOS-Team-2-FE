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
  
  static var userId: Int? = KeychainWrapper.standard.integer(forKey: "userId") {
    didSet {
      guard let userId = userId else { return }
      print("USER ID: \(userId)")
      KeychainWrapper.standard.set(userId, forKey: "userId")
    }
  }
  
}

struct Screen {
  static let maxWidth = UIScreen.main.bounds.width
  static let maxHeight = UIScreen.main.bounds.height
  
  static var safeAreaTop: CGFloat {
    let keyWindow = UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    return keyWindow.top
  }
  
  static var safeAreaBottom: CGFloat {
    let keyWindow = UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    return keyWindow.bottom
  }
}

public class Storage {
  static func isFirstTime() -> Bool {
    let defaults = UserDefaults.standard
    if defaults.object(forKey: "isFirstTime") == nil {
      defaults.set("No", forKey:"isFirstTime")
      return true
    } else {
      return false
    }
  }
}
