//
//  HistoryInfo.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/07.
//

import Foundation

struct HistoryInfo: Decodable {
  var timestamp: String? // 실패
  var status: Int? // 실패
  var error: String? // 실패
  var detail: String? // 실패
  var path: String? // 실패
  var nickname: String? // 성공
  var roleInFamily: String? // 성공
  var profileLink: String? // 성공
  var count: Int? // 성공
  var history: [History]? //성공
}

struct History: Decodable {
  var messageId: Int
  var content: String?
  var createdDate: String
  
  static func getDummy() -> Self{
    return History(messageId: 3, content: "지구는 우리 은하의 오리온자리 나선팔에 위치한 태양계를 구성하는 행성 중 하나로, 태양의 세 번째 궤도를 돌고 있다. 현재까지 과학적으로 알려진 바로는, 생명체와 지성체가 세운 문명이 존재하는 것이 입증된 유일한 천체로 인류가 살아 숨쉬다.", createdDate: "2022-12-25")
  }
  
  var descriptionContent: String{
    return "\(content ?? "")"
  }
  
  var descriptionDate: String{
    return "\(createdDate.toDateIncludeT()?.toString() ?? "")"
  }
}
