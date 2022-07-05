//
//  TaskTimePicker.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/05.
//

import SwiftUI

struct TaskTimePicker: View {
  
  @State private var time = Date()
  
  @State private var showTimePicker = false
  
  var body: some View {
    VStack{
      HStack(spacing: 0) {
        Image(systemName: "clock")
          .font(.system(size: 20))
          .frame(width: 24, height: 24)
          .foregroundColor(Color(hex:"4CAF50"))
          .padding(.trailing, 10)
        Text("시간")
          .font(.custom("Pretendard-Medium", size: 16))
          .foregroundColor(Color(hex: "121619"))
        Spacer()
        Text("\(time.getFormattedDate(format: "a hh:MM"))")
          .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
          .font(.custom("Pretendard-Medium", size: 13))
          .foregroundColor(Color(hex: "#43A047"))
          .frame(height: 28, alignment: .center)
          .background(Color(hex: "#E8F5E9"))
          .cornerRadius(4)
          .onTapGesture {
            self.showTimePicker.toggle()
          }
      }
      if showTimePicker {
        DatePicker(selection: $time, displayedComponents: .hourAndMinute) {}
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
        .frame(width: 358)
      }
    }
  }
}

struct TaskTimePicker_Previews: PreviewProvider {
  static var previews: some View {
    TaskTimePicker()
  }
}
