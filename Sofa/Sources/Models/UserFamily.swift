//
//  RegisterUser.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/23.
//

import Foundation

struct User: Decodable {
  let name: String
  let roleInFamily: String
  let birthDay: String
  let nickname: String
}

struct Family: Decodable {
  let familyName: String?
  let familyMotto: String?
  let nicknames: [Nickname]?
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

struct Nickname: Decodable {
  let pastNickname: String
  let newNickname: String
}
