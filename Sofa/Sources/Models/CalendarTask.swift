//
//  Task.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/21.
//

import SwiftUI

struct Task: Identifiable {
  var id = UUID().uuidString
  var title: String
  var time: Date = Date()
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
