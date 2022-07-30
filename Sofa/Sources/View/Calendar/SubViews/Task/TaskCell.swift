//
//  TaskCell.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/31.
//

import SwiftUI

struct TaskCell: View {
  @ObservedObject var task: Task
  
    var body: some View {
      
      HStack(spacing: 8){
        Rectangle()
          .fill(Color(hex: "E91E63"))
          .frame(width: 5, height: 48, alignment: .leading)
          .cornerRadius(8)
        VStack(alignment: .leading, spacing: 0){
          Text(task.title)
            .font(.custom("Pretendard-Bold", size: 16))
            .foregroundColor(Color(hex: "21272A"))
            .frame(alignment: .leading)
          Text(task.time)
//            .addingTimeInterval(CGFloat
//              .random(in: 0...5000)), style:
//              .time)
          .font(.custom("Pretendard-Medium", size: 14))
          .foregroundColor(Color(hex: "21272A"))
          .frame(alignment: .leading)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(task: Task(allDay: true, date: "2022-08-01", time: "08:25", title: "샘플", content: "샘플샘플", visibility: true, color: "BLUE"))
    }
}
