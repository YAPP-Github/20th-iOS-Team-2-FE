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
  
  var descriptionIntervalDate: String {
    let startDate = eventDate.toDateDay()
    let offsetComps = Calendar.current.dateComponents([.day], from: Date().stripTime(), to: startDate!)
    
    if offsetComps.day == 0{
      return "당일"
    }else{
      return "\(offsetComps.day ?? 0)일 전"
    }
  }
}
