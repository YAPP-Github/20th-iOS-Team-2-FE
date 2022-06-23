//
//  HomeView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct HomeView: View {
  @State var gotoAlarm = false
  var body: some View {
    VStack {
      NavigationView {
        VStack{
          List{
            EventList()
              .listRowInsets(EdgeInsets())
            
          }
          .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
          .listStyle(.plain)
          .navigationBarWithIconButtonStyle(isButtonClick: $gotoAlarm, buttonColor: Color(hex: "121619"), "우리가족 공간", "bell")
          .background(Color(hex: "EDEADF"))
        }
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
