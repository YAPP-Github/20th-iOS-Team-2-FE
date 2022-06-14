//
//  NavigationBarWithButton.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/11.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {
  @Binding var isButtonClick: Bool
  var title: String = ""
  var buttonName: String = ""
  var buttonColor: Color
  
  func body(content: Content) -> some View {
    return content
      .navigationBarItems(
        leading: Text(title)
          .font(.system(size: 24, weight: .bold))
          .padding(),
        trailing: Button(action: {
          UITabBar.toogleTabBarVisibility()
          isButtonClick = true
        }, label: {
          Image(systemName: buttonName)
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

struct NavigationBarWithButton_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      Color.gray.edgesIgnoringSafeArea(.all)
        .navigationBarWithButton(isButtonClick: .constant(true), buttonColor: Color.init(hex: "#43A047"), "제목", "plus")
    }
  }
}
