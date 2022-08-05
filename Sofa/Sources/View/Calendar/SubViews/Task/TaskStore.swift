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
      Task(allDay: true, date: "2022-08-07", time: "08:25", title: "복권 사기", content: "복권사기", visibility: true, color: "BLUE"),
      Task(allDay: true, date: "2022-08-13", time: "08:25", title: "가족여행 제주도", content: "파트회의", visibility: true, color: "PINK"),
      Task(allDay: false, date: "2022-07-31", time: "22:25", title: "소파 회의", content: "전체 정기  회의", visibility: true, color: "BLUE"),
      Task(allDay: true, date: "2022-07-31", time: "21:00", title: "경주 여행", content: "당일치기 경주 여행", visibility: true, color: "AMBER"),
      Task(allDay: false, date: "2022-07-31", time: "10:25", title: "스터디", content: "토익 그룹 스터디", visibility: true, color: "PINK"),
      Task(allDay: true, date: "2022-07-31", time: "18:25", title: "밥약속", content: "사거리에서 약속", visibility: true, color: "LIGHTGREEN"),
    ]
  }
  
  func insert(allDay: Bool, date: String, time: String, title: String, content: String, visibility: Bool, color: String) {
    list.insert(Task(allDay: allDay, date: date, time: time, title: title, content: content, visibility: visibility, color: color), at: 0)
  }
  
  func update(task: Task?, allDay: Bool, date: String, time: String, title: String, content: String, visibility: Bool, color: String) {
    guard let task = task else {
      return
    }
    task.allDay = allDay
    task.date = date
    task.time = time
    task.title = title
    task.content = content
    task.visibility = visibility
    task.color = color
  }
  
  func delete(task: Task) {
    list.removeAll() { $0.id == task.id }
  }
  
  func delete(set: IndexSet) {
    for index in set {
      list.remove(at: index)
    }
  }
}

