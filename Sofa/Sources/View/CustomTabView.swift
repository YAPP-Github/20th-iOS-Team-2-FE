//
//  CustomTabView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/19.
//

import SwiftUI

struct CustomTabView: View {
  
  @Binding var selection: Tab
  var body: some View {
    ZStack{
      HStack(alignment: .center, spacing: 8){
        ForEach(0..<4) { i in
          Spacer()
            .frame(width: Screen.maxWidth * 0.05)
          Button {
            switch i{
            case 0:
              selection = .home
            case 1:
              selection = .calendar
            case 2:
              selection = .album
            case 3:
              selection = .setting
            default:
              selection = .home
            }
          } label: {
            switch i{
            case 0:
              VStack{
                Image(systemName: selection == .home ? "hand.wave.fill" : "hand.wave")
                  .font(.system(size: selection == .home ? 24 : 24 ))
                  .padding(.vertical, 10)
                  .foregroundColor(selection == .home ? Color(hex: "43A047") : Color.gray)
                Spacer()
              }

            case 1:
              VStack{
                Image(systemName: "calendar")
                  .font(.system(size: 24))
                  .padding(.vertical, 10)
                  .foregroundColor(selection == .calendar ? Color(hex: "43A047") : Color.gray)
                Spacer()
              }
            case 2:
              VStack{
                Image(systemName: selection == .album ? "book.closed.fill" : "book.closed")
                  .font(.system(size: 24))
                  .padding(.vertical, 8.5)
                  .foregroundColor(selection == .album ? Color(hex: "43A047") : Color.gray)
                Spacer()
              }
            case 3:
              VStack{
                Image(systemName: "ellipsis")
                  .font(.system(size: 24))
                  .padding(.vertical, 17)
                  .foregroundColor(selection == .setting ? Color(hex: "43A047") : Color.gray)
                Spacer()
              }
            default:
              Image(systemName: "ellipsis")
                .font(.system(size: 24))
                .foregroundColor(selection == .setting ? Color(hex: "43A047") : Color.gray)
            }
          }
          
          Spacer()
            .frame(width: Screen.maxWidth * 0.05)
        } //HStack
        .frame(height: UIDevice().hasNotch ? Screen.maxHeight * 0.11 : Screen.maxHeight * 0.11 - 5)
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea(.all)
        
      }// ZStack
      .frame(width: Screen.maxWidth)
      .background(Color.white)
    }
//        .transition(.asymmetric(insertion: AnyTransition.move(edge: .bottom),                                removal: AnyTransition.move(edge: .leading)))
//        .animation(.easeIn) // Tabbar show animation
    .ignoresSafeArea(.keyboard)
    .edgesIgnoringSafeArea([.bottom])
  }
}

//struct CustomTabView_Previews: PreviewProvider {
//  static var previews: some View {
//    CustomTabView(selected: <#Binding<Int>#>)
//  }
//}
