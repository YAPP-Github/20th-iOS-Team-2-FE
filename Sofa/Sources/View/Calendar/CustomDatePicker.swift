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
      HStack{
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
        .frame(width: .infinity, height: 8, alignment: .center)
      
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
        
      }//HStack2
      .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
    }
  }
}

struct CustomDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
