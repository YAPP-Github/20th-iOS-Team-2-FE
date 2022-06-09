//
//  GreyOutOfFocusView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/08.
//

import SwiftUI

public struct GreyOutOfFocusView: View {
  let contentHight: CGFloat
  let opacity: CGFloat
  let callback: (() -> ())?
  
  public init(
    contentHight: CGFloat = 70,
    opacity: CGFloat = 0.7,
    callback: (() -> ())? = nil
  ) {
    self.contentHight = contentHight
    self.opacity = opacity
    self.callback = callback
  }
  
  var greyView: some View {
    Rectangle()
      .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      .background(Color.black)
      .opacity(Double(opacity))
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
    GreyOutOfFocusView()
  }
}
