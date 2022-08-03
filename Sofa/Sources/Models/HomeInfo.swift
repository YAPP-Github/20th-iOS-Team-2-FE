//
//  HomeInfo.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import Foundation

struct HomeInfo: Decodable {
  let timestamp: String? // 실패
  let status: Int? // 실패
  let detail: String? // 실패
  var familyName: String? // 성공
  var events: [Event]? // 성공
}

struct Event: Decodable {
  var title: String?
  var date: String?
  var color: String?
  
  static func getDummy() -> Self{
    return Event(title: "크리스마스 파티🎄", date: "2022-12-25")
  }
  
  var descriptionTitle: String{
    return "\(title ?? "")"
  }
  
  var descriptionDate: String{
    return "\(date ?? "")"
  }
  
  var descriptionIntervalDate: String {
    let startDate = date?.toDateDay()
    let offsetComps = Calendar.current.dateComponents([.day], from: Date().stripTime(), to: startDate!)
    
    if offsetComps.day == 0{
      return "당일"
    }else{
      return "\(offsetComps.day ?? 0)일 전"
    }
  }
}
