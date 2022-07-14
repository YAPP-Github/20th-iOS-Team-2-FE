//
//  Ex+String.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/10.
//

import Foundation

extension String {
  func toDate() -> Date? { // "yyyy-MM-dd HH:mm:ss"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
    
    if let date = dateFormatter.date(from: self) {
      return date
    } else {
      return nil
    }
  }
}
