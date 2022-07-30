//
//  Task.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/21.
//

import SwiftUI

struct Task: Identifiable {
  var id = UUID().uuidString
  var allDay: Bool
  var date: String //"2022-06-20"  var time: Date = Date()
  var time: String //"20:35"
  var title: String
  var content: String
  var visibility: Bool
  var color: String
}

struct TaskMetaData: Identifiable{
  var id = UUID().uuidString
  var task: [Task]
  var taskDate: Date
}

func getSampleDate(offset: Int)->Date{
  let calendar = Calendar.current
  let date = calendar.date(byAdding: .day, value: offset, to: Date())
  
  return date ?? Date()
}
