//
//  NavigationBarWithTextButtonStyle.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import SwiftUI

struct NavigationBarWithTextButtonStyle: ViewModifier {
  @Environment(\.presentationMode) var presentable
  @Binding var isNextClick: Bool
  @Binding var isTitleClick: Bool
  @Binding var isDisalbeNextButton: Bool
  @Binding var isDisalbeTitleButton: Bool
  var title: String = ""
  var nextText: String = ""
  var buttonColor: Color
  
  func body(content: Content) -> some View {
    return content
      .navigationBarItems(
        leading: Button(action: {
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Image(systemName: "chevron.left")
            Text("이전")
              .font(.custom("Pretendard-Medium", size: 16))
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          isNextClick = true
        }, label: {
          if !isDisalbeNextButton {
            Text(nextText)
              .font(.custom("Pretendard-Medium", size: 16))
          }
        })
        .disabled(isDisalbeNextButton)
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          VStack {
            Button(action: {
              isTitleClick = true
            }) {
              Text(title)
                .font(.custom("Pretendard-Medium", size: 16))
                .foregroundColor(Color.black)
                .bold()
            }
            .disabled(isDisalbeTitleButton)
          }
        }
      }
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
        .navigationBarWithTextButtonStyle(isNextClick: .constant(true), isTitleClick: .constant(true), isDisalbeNextButton: .constant(false), isDisalbeTitleButton: .constant(false), "제목", nextText: "올리기", Color.init(hex: "#43A047"))
    }
  }
}
