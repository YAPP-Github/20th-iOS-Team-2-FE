//
//  TaskMockData.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/05.
//

import Foundation

var tasks: [TaskMetaData] = [
  TaskMetaData(task: [
    Task(allDay: false, date: "2022-06-20", time: "20:35", title: "가족 식사", content: "한정식으로 고고", visibility: true, color: "#FFA000")
  ], taskDate: getSampleDate(offset: 0)),
  TaskMetaData(task: [
    Task(allDay: false, date: "2022-06-20", time: "20:35", title: "가족 식사", content: "한정식으로 고고", visibility: true, color: "#4589FF")
  ], taskDate: getSampleDate(offset: -3)),
  TaskMetaData(task: [
    Task(allDay: false, date: "2022-06-20", time: "20:35", title: "가족 식사", content: "한정식으로 고고", visibility: true, color: "#0072C3")
  ], taskDate: getSampleDate(offset: 5)),
  TaskMetaData(task: [
    Task(allDay: false, date: "2022-06-20", time: "20:35", title: "가족 식사", content: "한정식으로 고고", visibility: true, color: "#A56EFF")
  ], taskDate: getSampleDate(offset: -13)),
]
