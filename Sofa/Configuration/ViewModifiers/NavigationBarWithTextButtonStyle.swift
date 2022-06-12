//
//  NavigationBarWithTextButtonStyle.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import SwiftUI

struct NavigationBarWithTextButtonStyle: ViewModifier {
  @Binding var isNextClick: Bool
  @Binding var isDisalbeNextButton: Bool
  var title: String = ""
  var nextText: String = ""
  var buttonColor: Color
  
  func body(content: Content) -> some View {
    return content
      .navigationBarItems(
        leading: Button(action: {
          
        }, label: {
          HStack(spacing: 0) {
            Image(systemName: "chevron.left")
            Text("이전")
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          isNextClick = true
        }, label: {
          HStack(spacing: 0) {
            Text(nextText)
          }
        })
        .disabled(isDisalbeNextButton)
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle(title)
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

struct NavigationBarWithTextButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      Color.gray.edgesIgnoringSafeArea(.all)
        .navigationBarWithTextButtonStyle(isButtonClick: .constant(true), isDisalbeNextButton: .constant(false), "제목", nextText: "올리기", Color.init(hex: "#43A047"))
    }
  }
}
