//
//  CustomDatePicker.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/21.
//

import SwiftUI

struct CustomDatePicker: View {
  @EnvironmentObject var store: TaskStore
  @Binding var currentDate: Date
  @State var yearCount = 0
  @State var currentMonth = 0
  @State var showTaskDetail = false
  @State var showYearPicker = false
  
  var body: some View {
    VStack(spacing: 0){
      let days: [String] = ["일","월","화","수","목","금","토"]
      HStack(spacing: 0){
        Text(extraDate()[1] + "년 " + extraDate()[0])
          .font(.custom("Pretendard-Bold", size: 18))
          .foregroundColor(Color(hex: "121619"))
          .padding(.leading, 16)
        Button {
          withAnimation {
            showYearPicker.toggle()
          }
        } label: {
          Image(systemName: showYearPicker ? "chevron.down" : "chevron.right")
            .font(.system(size: 20))
            .foregroundColor(Color(hex: "121619"))
            .padding(.leading, 12.5)
        }
        Spacer(minLength: 0)
        Button {
          withAnimation{
            currentMonth -= 1
          }
        } label: {
          Image(systemName: "chevron.left")
            .font(.system(size: 20))
            .foregroundColor(Color(hex: "121619"))
        }
        Button {
          withAnimation{
            currentMonth += 1
          }
        } label: {
          Image(systemName: "chevron.right")
            .font(.system(size: 20))
            .foregroundColor(Color(hex: "121619"))
            .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 20.5))
        }
      }
      .padding(.top,15)
      
      ZStack{
        // Day
        if !showYearPicker {
          VStack{
            HStack(spacing: 0){
              ForEach(days, id: \.self){day in
                Text(day)
                  .font(.custom("Pretendard-Medium", size: 13))
                  .frame(maxWidth: .infinity)
                  .padding(.top, 10)
                  .foregroundColor(.black)
                  .opacity(0.4)
              }
            }
            // Dates
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 25) {
              ForEach(extractDate()){value in
                CardView(value: value)
                  .background(
                    Rectangle()
                      .fill(Color(hex: "4CAF50"))
                      .cornerRadius(4)
                      .frame(width: 32, height: 32, alignment: .center)
                      .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
                      .opacity(isSameDay(date1: value.dates, date2: currentDate) ? 1 : 0)
                  )
                  .onTapGesture {
                    currentDate = value.dates
                    print("currentDate : \(currentDate.getFormattedDate(format: "yyyy-MM-dd"))")
                  }
              }
            }
            .padding(EdgeInsets(top: 12, leading: 5, bottom: 0, trailing: 5))
          }
        }
        else {
          let previousMonth = Date().get(.month)
          let previousYear = Date().get(.year)
          DatePicker(selection: $currentDate, displayedComponents: .date) {}
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .onDisappear{
              yearCount = currentDate.get(.year) - previousYear
              currentMonth = 12*yearCount + currentDate.get(.month) - previousMonth
            }
        }
      }
      Border().padding(.top, 22)
      ScrollView(.vertical, showsIndicators: false) {
        // Task
        LazyVStack(spacing: 24) {
          ForEach(store.list){ task in
            let isSameDay = isSameDay(date1: task.date.toDateDay()!, date2: currentDate)
            if isSameDay {
              NavigationLink {
                TaskDetailView(task: task)
              } label: {
                TaskCell(task: task)
              }
            }
          }
        }
        .padding()
      }
      .onChange(of: currentMonth) { newValue in
        currentDate = getCurrentMonth()
      }
    }
    .onAppear {
      currentMonth = currentDate.get(.month) - Date().get(.month)
    }
  }
  
  func CardView(value: DateValue)->some View{
    VStack(spacing: 0) {
      if value.day != -1 {
        if let task = store.list.first(where: { task in
          return isSameDay(date1: task.date.toDateDay()!, date2: value.dates)
        }){
          Text("\(value.day)")
            .font(.custom("Pretendard-Medium", size: 14))
            .foregroundColor(isSameDay(date1: task.date.toDateDay()!, date2: currentDate) ? .white : Color(hex: "121619"))
          Circle()
            .fill(isSameDay(date1: task.date.toDateDay()!, date2: currentDate) ? .white : Color(hex: "66BB6A"))
            .frame(width: 6, height: 6)
            .padding(EdgeInsets(top: 1, leading: 0, bottom: -1, trailing: 0))
        }
        else {
          Text("\(value.day)")
            .font(.custom("Pretendard-Medium", size: 14))
            .foregroundColor(isSameDay(date1: value.dates, date2: currentDate) ? .white : Color(hex: "121619"))
            .frame(maxWidth: .infinity)
          
          Spacer()
        }
      }
    }
  }
  
  func isSameDay(date1: Date, date2: Date)->Bool{
    let calendar = Calendar.current
    return calendar.isDate(date1, inSameDayAs: date2)
  }
  
  func extraDate()->[String]{
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(abbreviation: "KST")
    formatter.dateFormat = "MMMM yyyy"
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
    let calendar = Calendar.current // currentDate로 변경
    let currentMonth = getCurrentMonth()
    var days = currentMonth.getAllDates().compactMap { date ->
      DateValue in
      let day = calendar.component(.day, from: date)
      return DateValue(day: day, dates: date)
    }
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
