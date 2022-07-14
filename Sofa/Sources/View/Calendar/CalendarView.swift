//
//  CalendarView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct CalendarView: View {
  
  @State var currentDate: Date = Date()
  @State private var showAppendTaskModal: Bool = false
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        Rectangle()
          .frame(height: 1.0, alignment: .bottom)
          .foregroundColor(Color(hex: "EDEADF"))
        
        Color(hex: "FAF8F0")
          .ignoresSafeArea()
          .frame(height: 8)
        
        CustomDatePicker(currentDate: $currentDate)
      }
      .navigationBarWithIconButtonStyle(isButtonClick: $showAppendTaskModal, buttonColor: Color(hex: "43A047"), "캘린더", "plus")
      .sheet(isPresented: self.$showAppendTaskModal) {
        AppendTaskModalView()
      }
    }
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
