//
//  Ex+Date.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import UIKit

let date = Date()
let format = date.getFormattedDate(format: "yyyy-MM-dd") // format

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.locale = Locale(identifier: "ko_KR")
        dateformat.timeZone = TimeZone(abbreviation: "KST")
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
  
  func getAllDates()->[Date]{
    let calendar = Calendar.current
    
    let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    
    let range = calendar.range(of: .day, in: .month, for: startDate)!
    
    return range.compactMap { day -> Date in
      return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
    }
  }
  
  func stripTime() -> Date { // 날짜에서 시간 제외
      let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
      let date = Calendar.current.date(from: components)
      return date!
  }
  
  // 사용법 예시 : print("day: \(date.get(.day)), month: \(date.get(.month)), year: \(date.get(.year))")
  func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
    return calendar.dateComponents(Set(components), from: self)
  }
  
  func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
    return calendar.component(component, from: self)
  }
  
}
