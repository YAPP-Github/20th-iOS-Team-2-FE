//
//  RegisterUser.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/23.
//

import Foundation

struct RegisterUser: Decodable {
  let name: String
  let roleInFamily: String
  let birthDay: String
  let nickname: String
  
  static func getDummy() -> Self{
    return RegisterUser(name: "홍길동", roleInFamily: "아들", birthDay: "1960-02-02", nickname: "홍길동")
  }
}

struct RegisterFamily: Decodable {
  let familyName: String
  let familyMotto: String
  
  static func getDummy() -> Self{
    return RegisterFamily(familyName: "우리가족 짱짱", familyMotto: "착하게 살자")
  }
}
