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
  
  func navigationBarWithTextButtonStyle(isButtonClick: Binding<Bool>, isDisalbeNextButton: Binding<Bool>, _ title: String, nextText: String, _ buttonColor: Color = Color(UIColor.label)) -> some View {
    return self.modifier(NavigationBarWithTextButtonStyle(isNextClick: isButtonClick, isDisalbeNextButton: isDisalbeNextButton, title: title, nextText: nextText, buttonColor: buttonColor))
  }
  
  func navigationBarInlineStyle(isNextClick: Binding<Bool>, isDisalbeNextButton: Binding<Bool>, buttonColor: Color = Color(UIColor.label), _ title: String = "") -> some View {
    return self.modifier(NavigationBarInlineStyle(isNextClick: isNextClick, isDisalbeNextButton: isDisalbeNextButton, title: title, buttonColor: buttonColor))
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
}
