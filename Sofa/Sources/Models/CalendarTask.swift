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

var tasks: [TaskMetaData] = [
  TaskMetaData(task: [
    Task(title: "토익 스터디"),
    Task(title: "운동가기"),
    Task(title: "소파 회의"),
    Task(title: "소파 회의"),
    Task(title: "소파 회의"),
    Task(title: "소파 회의")
  ], taskDate: getSampleDate(offset: 0)),
  TaskMetaData(task: [
    Task(title: "엄마한테 전화하기")
  ], taskDate: getSampleDate(offset: -3)),
  TaskMetaData(task: [
    Task(title: "홍대가기")
  ], taskDate: getSampleDate(offset: 5)),
  TaskMetaData(task: [
    Task(title: "밥먹기")
  ], taskDate: getSampleDate(offset: -13)),
]
