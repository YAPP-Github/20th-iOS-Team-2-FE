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
}

struct RegisterFamily: Decodable {
  let familyName: String
  let familyMotto: String
}

struct FamilyID: Decodable {
  let familyId: Int
}

struct SimpleUser: Decodable {
  let userId: Int?
  let nickname: String?
  let name: String?
  let roleInfamily: String?
  let imageLink: String?
}

struct DetailUser: Decodable {
  let nickname: String?
  let name: String?
  let roleInFamily: String?
  let birth: String?
  let imageLink: String?
}
