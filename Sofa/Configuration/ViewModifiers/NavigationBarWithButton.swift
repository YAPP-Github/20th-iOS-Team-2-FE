//
//  NavigationBarWithButton.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/11.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {
  @Binding var showingSheet: Bool
  var title: String = ""
  var buttonName: String = ""
  
  func body(content: Content) -> some View {
    return content
      .navigationBarItems(
        leading: Text(title)
          .font(.system(size: 24, weight: .bold))
          .padding(),
        trailing: Button(action: {
          UITabBar.toogleTabBarVisibility()
          showingSheet = true
        }, label: {
          Image(systemName: buttonName)
        })
        .accentColor(.black)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor =
        UIColor(white: 1, alpha: 0.6)
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
        .navigationBarWithButton(showingSheet: .constant(true), "앨범", "plus")
    }
  }
}
