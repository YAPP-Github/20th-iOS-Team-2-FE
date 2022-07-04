//
//  Constants.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI
import SwiftKeychainWrapper

class Constant{
  
  static var userID: String? = KeychainWrapper.standard.string(forKey: "userID") {
    didSet {
      guard let id = userID else { return }
      print("userID: \(userID ?? "0")")
      KeychainWrapper.standard.set(id, forKey: "userID")
    }
  }
  
  static var accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken") {
    didSet {
      guard let token = accessToken else { return }
      print("TOKEN: \(token)")
      KeychainWrapper.standard.set(token, forKey: "accessToken")
    }
  }
  
  static var refreshToken: String? = UserDefaults.standard.string(forKey: "refreshToken") {
    didSet {
      guard let token = refreshToken else { return }
      print("TOKEN: \(token)")
      KeychainWrapper.standard.set(token, forKey: "refreshToken")
    }
  }
}

struct Screen {
  static let maxWidth = UIScreen.main.bounds.width
  static let maxHeight = UIScreen.main.bounds.height
}
