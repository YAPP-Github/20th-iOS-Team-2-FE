//
//  CustomDatePicker.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/21.
//

import SwiftUI

struct CustomDatePicker: View {
  
  @Binding var currentDate: Date
  
  var body: some View {
    VStack(spacing: 0){
      
      // Days
      let days: [String] = ["일","월","화","수","목","금","토"]
      
      HStack(spacing: 0){
        Text("2022년 6월")
          .font(.custom("Pretendard-Bold", size: 18))
          .foregroundColor(Color(hex: "121619"))
          .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
        Button {
        } label: {
          Image(systemName: "chevron.right")
            .font(.custom("SF-pro", size: 20))
            .foregroundColor(Color(hex: "121619"))
            .padding(EdgeInsets(top: 0, leading: 12.5, bottom: 0, trailing: 0))
        }
        Spacer(minLength: 0)
        Button {
        } label: {
          Image(systemName: "chevron.left")
            .font(.custom("SF-pro", size: 20))
            .foregroundColor(Color(hex: "121619"))
          
        }
        Button {
        } label: {
          Image(systemName: "chevron.right")
            .font(.custom("SF-pro", size: 20))
            .foregroundColor(Color(hex: "121619"))
            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 20.5))
        }
      }
      .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
      
      // Day View
      HStack(spacing: 0){
        ForEach(days, id: \.self){day in
          Text(day)
            .font(.custom("Pretendard-Medium", size: 13))
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 9, leading: 0, bottom: 0, trailing: 0))
            .foregroundColor(.black)
            .opacity(0.4)
        }
      }
    }
  }
}

struct CustomDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
