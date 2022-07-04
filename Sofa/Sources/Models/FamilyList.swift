//
//  FamilyList.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/03.
//

import Foundation

struct familyList: Decodable {
  var members: [Member]
}

struct Member: Decodable, Hashable {
  var userId: Int
  var image: String
  var nickname: String
  var role: String
  var updatedAt: String
  var emoji: Int
  var content: String
  
  static func getDummy() -> Self{
    return Member(userId: 1, image: "https:// .... ", nickname: "닉네임", role: "아들", updatedAt: "2022-06-04 22:08", emoji: 2, content: "지구는 우리 은")
  }
  
  var descriptionRole: String{
    return "\(role)"
  }
  
  var descriptionNickname: String{
    return "\(nickname)"
  }
  
  var descriptionContent: String{
    return "\(content)"
  }
}
