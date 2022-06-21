//
//  CustomDatePicker.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/21.
//

import SwiftUI
import simd
import Alamofire

struct CustomDatePicker: View {
  
  @Binding var currentDate: Date
  
  @State var currentMonth: Int = 0
  
  var body: some View {
    VStack(spacing: 0){
      
      let days: [String] = ["일","월","화","수","목","금","토"]
      
      HStack(spacing: 0){
        Text(extraDate()[1] + "년 " + extraDate()[0])
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
          withAnimation{
            currentMonth -= 1
          }
        } label: {
          Image(systemName: "chevron.left")
            .font(.custom("SF-pro", size: 20))
            .foregroundColor(Color(hex: "121619"))
          
        }
        Button {
          withAnimation{
            currentMonth += 1
          }
        } label: {
          Image(systemName: "chevron.right")
            .font(.custom("SF-pro", size: 20))
            .foregroundColor(Color(hex: "121619"))
            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 20.5))
        }
      }
      .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
      
      // Day
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
      
      // Dates
      let columns = Array(repeating: GridItem(.flexible()), count: 7)
      LazyVGrid(columns: columns, spacing: 27) {
        ForEach(extractDate()){value in
          CardView(value: value)
        }
      }
      /// padding값 수정
      .padding(EdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 5))
    }
    .onChange(of: currentMonth) { newValue in
      currentDate = getCurrentMonth()
    }
  }
  
  @ViewBuilder
  func CardView(value: DateValue)->some View{
    VStack {
      if value.day != -1 {
        Text("\(value.day)")
          .font(.custom("Pretendard-Medium", size: 14))
          .foregroundColor(Color(hex: "121619"))
      }
    }
  }
  
  func extraDate()->[String]{
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(abbreviation: "KST")
    formatter.dateFormat = "MMMM YYYY"
    let date = formatter.string(from: currentDate)
    
    return date.components(separatedBy: " ")
  }
  
  func getCurrentMonth()->Date{
    let calendar = Calendar.current
    
    guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
      return Date()
    }
    
    return currentMonth
  }
  
  func extractDate()->[DateValue] {
    //Getting Current Month Date
    let calendar = Calendar.current
    
    let currentMonth = getCurrentMonth()
    
    var days = currentMonth.getAllDates().compactMap { date ->
      DateValue in
      
      let day = calendar.component(.day, from: date)
      
      return DateValue(day: day, dates: date)
    }
    
    // adding offset days to get exact week day
    let firstWeekday = calendar.component(.weekday, from: days.first?.dates ?? Date())
    
    for _ in 0..<firstWeekday - 1{
      days.insert(DateValue(day: -1, dates: Date()), at: 0)
    }
    
    return days
  }
}

struct CustomDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}

extension Date{
  func getAllDates()->[Date]{
    let calendar = Calendar.current
    
    let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    
    let range = calendar.range(of: .day, in: .month, for: startDate)!
    
    return range.compactMap { day -> Date in
      return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
    }
  }
}
