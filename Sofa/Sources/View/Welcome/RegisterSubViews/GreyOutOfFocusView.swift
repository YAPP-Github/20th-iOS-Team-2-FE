//
//  GreyOutOfFocusView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/14.
//

import SwiftUI

public struct GreyOutOfFocusView: View {
  let contentHight: CGFloat
  let opacity: CGFloat
  let callback: (() -> ())?
  var tabBarHight: CGFloat
  
  public init(
    contentHight: CGFloat = 70,
    opacity: CGFloat = 0.2,
    callback: (() -> ())? = nil,
    tabBarHight: CGFloat = 83 // 임시
  ) {
    self.contentHight = contentHight
    self.opacity = opacity
    self.callback = callback
    self.tabBarHight = tabBarHight
  }
  
  var greyView: some View {
    Rectangle()
      .frame(width: Screen.maxWidth, height: Screen.maxHeight - tabBarHight)
      .background(Color.black)
      .opacity(opacity)
      .onTapGesture {
        callback?()
      }
      .edgesIgnoringSafeArea(.all)
  }
  
  public var body: some View {
    greyView
  }
}

struct GreyOutOfFocusView_Previews: PreviewProvider {
  static var previews: some View {
    GreyOutOfFocusView(opacity: 0.2)
  }
}
