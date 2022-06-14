//
//  HiddenTabBar.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI

struct HiddenTabBar: ViewModifier {
  var animated = true
  
  func body(content: Content) -> some View {
    return content.padding(.zero).onAppear {
      UITabBar.hideTabBar(animated: animated)
    }
  }
}
