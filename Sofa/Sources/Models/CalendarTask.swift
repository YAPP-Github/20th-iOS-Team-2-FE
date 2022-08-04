//
//  Task.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/21.
//

import SwiftUI

class Task: Identifiable, ObservableObject {
  let id: UUID
  @Published var allDay: Bool
  @Published var date: String
  @Published var time: String
  @Published var title: String
  @Published  var content: String
  @Published var visibility: Bool
  @Published var color: String
  
  init(allDay: Bool, date: String, time: String, title: String, content: String, visibility: Bool, color: String) {
    id = UUID()
    self.allDay = allDay
    self.date = date
    self.time = time
    self.title = title
    self.content = content
    self.visibility = visibility
    self.color = color
  }
}

struct TaskMetaData: Identifiable{
  var id = UUID().uuidString
  var task: [Task]
}

func getSampleDate(offset: Int)->Date{
  let calendar = Calendar.current
  let date = calendar.date(byAdding: .day, value: offset, to: Date())
  
  return date ?? Date()
}
