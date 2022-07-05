//
//  HomeView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct HomeView: View {
  
  @State var gotoAlarm = false
  @State var showModal = false
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack{
          ScrollView{
            LazyVStack{
              EventList()
                .frame(height: 64)
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color(hex: "EDEADF")), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color(hex: "EDEADF")), alignment: .bottom)
            .background(Color(hex: "F5F2E9"))
            ChatList()
              .onTapGesture {
                self.showModal = true
                UITabBar.hideTabBar(animated: false)
              }
          }// ScrollView
          .background(Color(hex: "F9F7EF"))
          EmojiView()
            .offset(x: 0, y: -24)
            .padding(.horizontal, 23)
        }// VStack
        .background(Color(hex: "F9F7EF"))
        .navigationBarWithIconButtonStyle(isButtonClick: $gotoAlarm, buttonColor: Color(hex: "121619"), "우리가족 공간", "bell")
      }// NavigationView
      ModalView(isShowing: $showModal)
        .onDisappear {
          UITabBar.showTabBar(animated: false)
        }
    }// ZStack
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
