//
//  CalendarView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct CalendarView: View {
  
  @State var currentDate: Date = Date()
  
  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0){
        Text("캘린더")
          .font(.custom("Pretendard-Bold", size: 24))
          .foregroundColor(Color(hex: "121619"))
          .padding(EdgeInsets(top: 0, leading: 24, bottom: 12, trailing: 0))
        Spacer()
        Button {
          
        } label: {
          Image(systemName: "plus")
            .font(.custom("SF-pro", size: 20))
            .foregroundColor(Color(hex: "43A047"))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 31))
          
        }
      }
      Rectangle()
        .frame(height: 1.0, alignment: .bottom)
        .foregroundColor(Color(hex: "EDEADF"))
      
      Color(hex: "FAF8F0")
        .ignoresSafeArea()
        .frame(height: 8)
      
      CustomDatePicker(currentDate: $currentDate)
    }
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
