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
}
