//
//  TaskStore.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/31.
//

import Foundation

class TaskStore: ObservableObject {
  @Published var list: [Task]
  
  init() {
    list = [
      Task(allDay: true, date: "2022-07-21", time: "08:25", title: "회의", content: "전체회의", visibility: true, color: "BLUE"),
      Task(allDay: true, date: "2022-07-01", time: "08:25", title: "회의2", content: "전체회의", visibility: true, color: "BLUE"),
      Task(allDay: true, date: "2022-07-11", time: "08:25", title: "회의3", content: "전체회의", visibility: true, color: "BLUE"),
    ]
  }
  
  func insert(allDay: Bool, date: String, time: String, title: String, content: String, visibility: Bool, color: String) {
    list.insert(Task(allDay: allDay, date: date, time: time, title: title, content: content, visibility: visibility, color: color), at: 0)
  }
  
//  func update(task: Task?, allDay: Bool, date: String, time: String, title: String, content: String, visibility: Bool, color: String) {
//    guard var task = task else {
//      return
//    }
//    task.allDay = allDay
//    task.date = date
//    task.time = time
//    task.title = title
//    task.content = content
//    task.visibility = visibility
//    task.color = color
//  }
  
  func delete(task: Task) {
    list.removeAll() { $0.id == task.id }
  }
  
  func delete(set: IndexSet) {
    for index in set {
      list.remove(at: index)
    }
  }
}

