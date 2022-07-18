//
//  Notifications.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/10.
//

import Foundation

struct Notifications: Decodable, Hashable {
  var notifications: [Notification]
}

struct Notification: Decodable, Hashable {
  var type: String
  var user: String
  var targetId: Int
  var createdDate: String
  
  static func getDummy() -> Self{
    return Notification(type: "CALENDAR", user: "엄마 아빠 딸", targetId: 3, createdDate: "2022-06-05 22:30")
  }
  
  var descriptionUser: String{
    return "\(user)"
  }
  
  var descriptionDate: String{
    return "\(createdDate)"
  }
  
  var descriptionIntervalTime: String{
    let diff = Date().timeIntervalSince(createdDate.toDate() ?? Date())
    
    switch diff {
    case 0..<60:
      return "방금 전"
    case 60..<3600:
      return "\(Int(diff/60))분 전"
    case 3600..<86400: // 24시간 이전
      return "\(Int(diff/3600))시간 전"
    case 86400..<2592000: // 이번 주 & 이번 달
      return "\(Int(diff/86400))일 전"
    default:
      return createdDate.split(separator: " ").map{String($0)}.first!
    }
  }
  
  var getIntervalTime: Int {
    let diff = Date().timeIntervalSince(createdDate.toDate() ?? Date())
    
    return Int(diff)
  }
}
