//
//  ModalBackGround.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/08.
//

import SwiftUI

struct ModalBackGround: View {
  var callback: (() -> ())? = nil
  
  var body: some View {
    Rectangle()
      .frame(width: Screen.maxWidth, height: Screen.maxHeight)
      .background(Color.clear)
      .opacity(0.00001) // 투명
      .onTapGesture {
        callback?() // 배경을 click 했을 경우
      }
      .ignoresSafeArea()
  }
}

struct ModalBackGround_Previews: PreviewProvider {
  static var previews: some View {
    ModalBackGround()
  }
}
