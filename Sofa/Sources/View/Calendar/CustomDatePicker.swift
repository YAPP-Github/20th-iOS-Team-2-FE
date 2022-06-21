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
    VStack(spacing: 35){
      HStack(spacing: 20){
        Text("2022년")
          .font(.caption)
          .fontWeight(.semibold)
        
        Text("6월")
          .font(.title.bold())
        Spacer(minLength: 0)
        Button {
          
        } label: {
          Image(systemName: "chevron.left")
            .font(.title2)
        }
        Button {
          
        } label: {
          Image(systemName: "chevron.right")
            .font(.title2)
        }
      }//HStack
      .padding(.horizontal)
    }
  }
}

struct CustomDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
