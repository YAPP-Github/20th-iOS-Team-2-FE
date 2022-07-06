//
//  HomeView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var eventViewModel = EventViewModel()
  @State var gotoAlarm = false

  var body: some View {
    VStack {
      NavigationView {
        VStack{
          ScrollView{
            LazyVStack{
              EventList(eventViewModel: eventViewModel, page: .first(), alignment: .start)
                .frame(height: eventViewModel.events.count == 0 ? 0 : 64)
                .padding(.vertical, eventViewModel.events.count == 0 ? 0 : 16)
                .animation(.default)
            }
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color(hex: "EDEADF")), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color(hex: "EDEADF")), alignment: .bottom)
            .background(Color(hex: "F5F2E9"))
            ChatList()
          }// ScrollView
          .background(Color(hex: "F9F7EF"))
          EmojiView()
            .offset(x: 0, y: -24)
            .padding(.horizontal, 23)
        }// VStack
        .background(Color(hex: "F9F7EF"))
        .navigationBarWithIconButtonStyle(isButtonClick: $gotoAlarm, buttonColor: Color(hex: "121619"), "우리가족 공간", "bell")
      }// NavigationView
    }// VStack
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
