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
}
