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
}
