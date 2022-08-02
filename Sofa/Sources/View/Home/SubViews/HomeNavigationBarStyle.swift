//
//  HomeNavigationBarStyle.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/08.
//

import Foundation
import SwiftUI

struct HomeNavigationBarStyle: ViewModifier {
  @Binding var isButtonClick: Bool
  @Binding var title: String
  var buttonName: String = ""
  var buttonColor: Color
  
  func body(content: Content) -> some View {
    return content
      .navigationBarItems(
        leading: Text("\(title)")
          .font(.system(size: 24, weight: .bold))
          .padding(EdgeInsets(top: 8, leading: 8 * 24 / 30.5, bottom: 8, trailing: 8)), // trailing Item 기준 비율로 맞춰줌
        trailing: Button(action: {
//          UITabBar.hideTabBar(animated: false)
          isButtonClick = true
        }, label: {
          Image(systemName: buttonName)
            .font(Font.body.weight(.medium))
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor =
        UIColor.systemBackground.withAlphaComponent(1)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
      }
  }
}

//struct HomeNavigationBarStyle_Previews: PreviewProvider {
//  static var previews: some View {
//    NavigationView {
//      Color.gray.edgesIgnoringSafeArea(.all)
//        .navigationBarWithIconButtonStyle(isButtonClick: .constant(true), buttonColor: Color.init(hex: "#43A047"), "제목", "plus")
//    }
//  }
//}
