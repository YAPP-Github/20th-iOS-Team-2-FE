//
//  NavigationBarWithButton.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/04.
//

import SwiftUI

struct NavigationBarWithButton: ViewModifier {
  var title: String = ""
  
  func body(content: Content) -> some View {
    return content
      .navigationBarItems(
        leading: Text(title)
          .font(.system(size: 24, weight: .bold))
          .padding(),
        trailing: Button(
          action: {
            //                        print("알림버튼 tapped")
          },
          label: {
            Image(systemName: "plus")
          }
        )
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

extension View {
  func navigaionBarWithButtonStyle(_ title: String) -> some View {
    return self.modifier(NavigationBarWithButton(title: title))
  }
}

struct NavigationBarWithButton_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      Color.gray.edgesIgnoringSafeArea(.all)
        .navigaionBarWithButtonStyle("앨범")
    }
  }
}
