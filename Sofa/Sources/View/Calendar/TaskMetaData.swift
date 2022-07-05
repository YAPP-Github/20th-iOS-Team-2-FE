//
//  TaskMockData.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/05.
//

import Foundation

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
