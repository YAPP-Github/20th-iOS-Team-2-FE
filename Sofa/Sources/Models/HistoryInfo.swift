//
//  HistoryInfo.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/07.
//

import Foundation

struct HistoryInfo: Decodable {
  var nickname: String
  var roleInFamily: String
  var profileLink: String
  var count: Int
  var history: [History]
}

struct History: Decodable {
  var messageId: Int
  var content: String
  var createdDate: String
  
  static func getDummy() -> Self{
    return History(messageId: 3, content: "지구는 우리 은하의 오리온자리 나선팔에 위치한", createdDate: "2022-12-25")
  }
  
  var descriptionContent: String{
    return "\(content)"
  }
  
  var descriptionDate: String{
    return "\(createdDate)"
  }
}
