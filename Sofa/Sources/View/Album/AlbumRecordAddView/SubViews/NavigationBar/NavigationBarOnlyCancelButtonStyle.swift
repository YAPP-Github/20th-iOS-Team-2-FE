//
//  NavigationBarOnlyCancelButtonStyle.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/17.
//

import SwiftUI

struct NavigationBarOnlyCancelButtonStyle: ViewModifier {
  @Environment(\.presentationMode) var presentable
  var title: String = ""
  
  func body(content: Content) -> some View {
    return content
      .navigationBarItems(
        leading: Button(action: {
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Text("취소")
          }
        })
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle(title)
      .foregroundColor(Color.white)
      .onAppear {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor =
        UIColor.black
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 제목의 색상
      }
  }
}

extension View {
  func navigationBarOnlyCancelButtonStyle(_ title: String = "") -> some View {
    return self.modifier(NavigationBarOnlyCancelButtonStyle(title: title))
  }
}


struct NavigationBarOnlyCancelButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      Color.gray.edgesIgnoringSafeArea(.all)
        .navigationBarOnlyCancelButtonStyle("제목")
    }
  }
}
