//
//  NavigationBarInlineStyle.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/11.
//

import SwiftUI

struct NavigationBarInlineStyle: ViewModifier {
  @Environment(\.presentationMode) var presentable
  @Binding var isNextClick: Bool
  @Binding var isDisalbeNextButton: Bool
  var title: String
  var buttonColor: Color

  func body(content: Content) -> some View {
    return content
      .navigationBarItems(
        leading: Button(action: {
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Image(systemName: "chevron.left")
            Text("취소")
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          isNextClick = true
        }, label: {
          HStack(spacing: 0) {
            Text("다음")
            Image(systemName: "chevron.right")
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

struct NavigationBarInlineStyle_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      Color.gray.edgesIgnoringSafeArea(.all)
        .navigationBarInlineStyle(isNextClick: .constant(true), isDisalbeNextButton: .constant(true), buttonColor: Color.init(hex: "#43A047"), "제목")
    }
  }
}
