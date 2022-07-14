//
//  Highlighting.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/10.
//

import Foundation
import SwiftUI

// TextField 선택 시 하이라이트 기능
struct RectangleHighlightedViewModifier: ViewModifier {
  var firstLineWidth: CGFloat
  var secondLineWidth: CGFloat
  
  func body(content: Content) -> some View {
    content
      .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(Color(hex: "#43A047"), lineWidth: firstLineWidth))
      .padding(4)
      .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color(hex:"4CAF50").opacity(0.5), lineWidth: secondLineWidth))
  }
}

// Circle 선택 시 하이라이트 기능
struct CircleHighlightedViewModifier: ViewModifier {
  var lineWidth: CGFloat
  
  func body(content: Content) -> some View {
    content
      .padding(4)
      .overlay(Circle().strokeBorder(Color(hex:"4CAF50").opacity(0.5), lineWidth: lineWidth))
  }
}
