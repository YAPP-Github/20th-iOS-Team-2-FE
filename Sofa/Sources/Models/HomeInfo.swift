//
//  HomeInfo.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import Foundation

struct HomeInfo: Decodable {
  var familyName: String
  var events: [Event]
}

struct Event: Decodable {
  var title: String
  var eventDate: String
  
  static func getDummy() -> Self{
    return Event(title: "크리스마스 파티🎄", eventDate: "2022-12-25")
  }
  
  var descriptionTitle: String{
    return "\(title)"
  }
  
  var descriptionDate: String{
    return "\(eventDate)"
  }
}
