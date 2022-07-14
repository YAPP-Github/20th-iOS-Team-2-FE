//
//  tmpView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/05.
//

import SwiftUI

struct GeneralDatePickerView: View {
  
  @Binding var showDatePicker: Bool
  @Binding var enableToggle: Bool
  @Binding var currentDate: Date
 
  var body: some View {
    
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        Image(systemName: "calendar")
          .font(.system(size: 20))
          .frame(width: 24, height: 24)
          .foregroundColor(Color(hex:"4CAF50"))
          .padding(.trailing, 10)
        Text("날짜")
          .font(.custom("Pretendard-Medium", size: 16))
          .foregroundColor(Color(hex: "121619"))
        Spacer()
        Text("\(currentDate.getFormattedDate(format: "yyyy-MM-dd"))")
          .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
          .font(.custom("Pretendard-Medium", size: 13))
          .foregroundColor(Color(hex: "#43A047"))
          .frame(height: 28, alignment: .center)
          .background(Color(hex: "#E8F5E9"))
          .cornerRadius(4)
          .onTapGesture {
            withAnimation {
              self.showDatePicker.toggle()
            }
          }
      }.padding(.bottom, 12)
      if showDatePicker {
        GeneralCalendar(currentDate: $currentDate)
      }
    }
  }
}

struct GeneralDatePickerView_Previews: PreviewProvider {
  static var previews: some View {
    GeneralDatePickerView(showDatePicker: .constant(true), enableToggle: .constant(false), currentDate: .constant(Date()))
  }
}
