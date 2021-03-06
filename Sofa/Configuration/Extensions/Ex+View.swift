//
//  Ex+View.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI
import protocol SwiftUI.View
import struct SwiftUI.AnyView

public extension View {
  func navigationBarWithIconButtonStyle(isButtonClick: Binding<Bool>, buttonColor: Color = Color(UIColor.label), _ title: String, _ buttonName: String) -> some View {
    return self.modifier(NavigationBarWithIconButtonStyle(isButtonClick: isButtonClick, title: title, buttonName: buttonName, buttonColor: buttonColor))
  }
  
  func navigationBarWithTextButtonStyle(isNextClick: Binding<Bool>, isTitleClick: Binding<Bool>, isDisalbeNextButton: Binding<Bool>, isDisalbeTitleButton: Binding<Bool>,_ title: String, nextText: String, _ buttonColor: Color = Color(UIColor.label)) -> some View {
    return self.modifier(NavigationBarWithTextButtonStyle(isNextClick: isNextClick, isTitleClick: isTitleClick, isDisalbeNextButton: isDisalbeNextButton, isDisalbeTitleButton: isDisalbeTitleButton, title: title, nextText: nextText, buttonColor: buttonColor))
  }
  
  func navigationBarInlineStyle(isNextClick: Binding<Bool>, isDisalbeNextButton: Binding<Bool>, buttonColor: Color = Color(UIColor.label), _ title: String = "") -> some View {
    return self.modifier(NavigationBarInlineStyle(isNextClick: isNextClick, isDisalbeNextButton: isDisalbeNextButton, title: title, buttonColor: buttonColor))
  }
  
  func homenavigationBarStyle(isButtonClick: Binding<Bool>, buttonColor: Color = Color(UIColor.label), _ title: Binding<String>, _ buttonName: String) -> some View {
    return self.modifier(HomeNavigationBarStyle(isButtonClick: isButtonClick, title: title, buttonName: buttonName, buttonColor: buttonColor))
  }
  
  /// 탭바 숨김 처리 여부
  /// - Parameter isHidden:
  /// - Returns:
  func setTabBarVisibility(isHidden : Bool) -> some View {
    background(TabBarAccessor { tabBar in
      // print(">> TabBar height: \(tabBar.bounds.height)")
      // !! use as needed, in calculations, @State, etc.
      // 혹은 높이를 변경한다던지 여러가지 설정들이 가능하다.
      tabBar.isHidden = isHidden
    })
  }
  
  func showTabBar(animated: Bool = true) -> some View {
    return self.modifier(ShowTabBar(animated: animated))
  }
  func hideTabBar(animated: Bool = true) -> some View {
    return self.modifier(HiddenTabBar(animated: animated))
  }
  
  func shouldHideTabBar(_ hidden: Bool, animated: Bool = true) -> AnyView {
    if hidden {
      return AnyView(hideTabBar(animated: animated))
    } else {
      return AnyView(showTabBar(animated: animated))
    }
  }
  
  // Image 확대
  func pinchToZoom() -> some View {
    self.modifier(PinchToZoom())
  }
  
  // TextField 커스텀 플레이스 홀더
  func placeholder<PlaceHolderText: View>(shouldShow: Bool,
                                             alignment: Alignment = .leading,
                                             @ViewBuilder placeholderText: () -> PlaceHolderText
  ) -> some View{
    ZStack(alignment: alignment) {
      placeholderText().opacity(shouldShow ? 1 : 0)
      self
    }
  }
  
  // TextField padding 조정
  func customTextField(color: Color = .secondary, padding: CGFloat = 3, lineWidth: CGFloat = 0.0) -> some View { // <- Default settings
    self.modifier(TextFieldModifier(color: color, padding: padding, lineWidth: lineWidth))
  }
  
  // TextField 선택 시 하이라이트 기능
  func highlightTextField(firstLineWidth: CGFloat, secondLineWidth: CGFloat) -> some View {
    self.modifier(RectangleHighlightedViewModifier(firstLineWidth: firstLineWidth, secondLineWidth: secondLineWidth))
  }
  
  // Circle 선택 시 하이라이트 기능
  func highlightColor(lineWidth: CGFloat) -> some View {
    self.modifier(CircleHighlightedViewModifier(lineWidth: lineWidth))
  }
 
  // animation 비활성화
  func animationsDisabled() -> some View {
      return self.transaction { (tx: inout Transaction) in
          tx.disablesAnimations = true
          tx.animation = nil
      }.animation(nil)
  }
  
  @ViewBuilder func scrollEnabled(_ enabled: Bool) -> some View {
    if enabled {
      self
    } else {
      simultaneousGesture(DragGesture(minimumDistance: 0),
                          including: .all)
    }
  }
}

// TextField padding 조정
struct TextFieldModifier: ViewModifier {
  let color: Color
  let padding: CGFloat // <- space between text and border
  let lineWidth: CGFloat

  func body(content: Content) -> some View {
    content
      .padding(padding)
      .overlay(RoundedRectangle(cornerRadius: padding)
                .stroke(color, lineWidth: lineWidth)
      )
  }
}
