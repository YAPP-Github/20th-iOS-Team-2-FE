//
//  SetNotificationView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/25.
//

import SwiftUI

struct SetNotificationView: View {
  @ObservedObject var tabbarManager = TabBarManager.shared
  @State private var setNotification = true
  @State private var title = "알림"
  
  var body: some View {
    ZStack{
      NavigationView{
        ZStack{
          VStack(spacing: 0){
            Border()
            Rectangle()
              .foregroundColor(Color(hex: "FAF8F0"))
              .frame(height: 8)
            VStack(spacing: 0){
              HStack(alignment: .center) {
                Spacer()
                  .frame(width: 16)
                Text("알림 받기")
                  .font(.custom("Pretendard-Medium", size: 16))
                Spacer()
                Toggle("", isOn: $setNotification)
                  .toggleStyle(SwitchToggleStyle(tint: Color(hex: "4CAF50")))
                  .onChange(of: setNotification) { newValue in
                    print(setNotification)
                  }
                
                Spacer()
                  .frame(width: 16)
              }//HStack
              .frame(height: 80)
              .background(Color.white)
              Rectangle()
                .fill(Color(hex: "EDEADF"))
                .frame(height: 1)
                .background(Color.black)
              Spacer()
            }//VStack
            
          }//VStack
          .onAppear{
            tabbarManager.showTabBar = false
          }
          .background(Color(hex: "FAF8F0"))
          .background(Color(hex: "FAF8F0"))
          .edgesIgnoringSafeArea([.bottom])
        }//ZStack
        .navigationBarWithTextButtonStyle(isNextClick: .constant(false), isTitleClick: .constant(false), isDisalbeNextButton: .constant(false), isDisalbeTitleButton: .constant(false), title, nextText: "", Color.init(hex: "#43A047"))
      }//NavigationView
      .navigationBarHidden(true)
    }//ZStack
    
  }//body
}

struct SetNotificationView_Previews: PreviewProvider {
  static var previews: some View {
    SetNotificationView()
  }
}
