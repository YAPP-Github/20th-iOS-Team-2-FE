//
//  Comment.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/10.
//

import Foundation

struct CommensAPIResponse: Decodable {
  var comments: [Comment]
}

struct Comment: Decodable {
  var commentId: Int
  var writerId: Int
  var profileLink: String
  var nickname: String
  var roleInFamily: String
  var createdDate: String
  var content: String
  
  static func getDummy() -> Self{
    return Comment(commentId: 0, writerId: 0, profileLink: "", nickname: "별명", roleInFamily: "엄마", createdDate: "2022-07-04 20:20:00", content: "또 놀러가고싶다또 놀러가고싶다또 놀러가고싶다또 놀러가고싶다또 놀러가고싶다또 놀러가고싶다 \n댓글에 \n계속 \n줄바꿈을 \n누를 \n때 \n별다른 \n제한은 \n없다.\n\n\n\n")
  }
  
  // 마지막 공백 제거하여 반환
  var descriptionContent: String {
    var content = content
    
    while content.hasSuffix("\n") {
      content.removeLast()
      content.removeLast()
    }
    return "\(content)"
  }
  
  // 시간 차이로 나타내기
  var descriptionDate: String {
    let diff = Date().timeIntervalSince(createdDate.toDate() ?? Date())
    
    switch diff {
    case 0..<60:
      return "방금 전"
    case 60..<3600:
      return "\(Int(diff/60))분 전"
    case 3600..<86400: // 24시간 이전
      return "\(Int(diff/3600))시간 전"
    case 86400..<604800: // 이번주 내
      return "\(Int(diff/86400))일 전"
    default:
      return createdDate.split(separator: " ").map{String($0)}.first!
    }
  }
}
