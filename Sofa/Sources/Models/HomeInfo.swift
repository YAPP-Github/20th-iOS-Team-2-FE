//
//  HomeInfo.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import Foundation

struct HomeInfo: Hashable, Decodable {
  var familyName: String?
  var events: [Event]
}

struct Event: Identifiable, Hashable, Decodable {
  var id = UUID()
  var title: String?
  var eventDate: String?
  
  static func getDummy() -> Self{
    return Event(id: UUID(), title: "크리스마스 파티🎄", eventDate: "2022-12-25")
  }
  
  var descriptionTitle: String{
    return "\(title ?? "")"
  }
  
  var descriptionDate: String{
    return "\(eventDate ?? "")"
  }
}
