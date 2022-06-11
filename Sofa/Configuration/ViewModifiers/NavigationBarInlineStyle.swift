//
//  NavigationBarInlineStyle.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/11.
//

import SwiftUI

struct NavigationBarInlineStyle: ViewModifier {
  
  func body(content: Content) -> some View {
    return content
      
  }
}

struct NavigationBarInlineStyle_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      Color.gray.edgesIgnoringSafeArea(.all)
    }
  }
}
