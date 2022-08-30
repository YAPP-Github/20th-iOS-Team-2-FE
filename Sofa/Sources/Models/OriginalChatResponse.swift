//
//  OriginalChatResponse.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/31.
//

import Foundation

struct OriginalChatResponse: Decodable {
  let timestamp: String? // 실패
  let status: Int? // 실패
  let detail: String? // 실패
  var members: [ChatMember]? // 성공
}

struct ChatMember: Decodable, Hashable {
  var userId: Int
  var image: String
  var nickname: String
  var role: String
  var updatedAt: String
  var emoji: Int
  var content: String?
  
  var descriptionTimeInterval: String{
    if updatedAt == "방금전"{
      return updatedAt
    }else{
      let diff = Date().timeIntervalSince(String(updatedAt.prefix(19)).toDateIncludeT() ?? Date())
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
        return String(updatedAt.prefix(10))
      }
    }
  }
}
