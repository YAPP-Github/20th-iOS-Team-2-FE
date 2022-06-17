//
//  AudioBarView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/17.
//

import SwiftUI

struct AudioBarView: View {
  var color: Color
  var isStep: Bool // 색상을 변경할지 결졍
  
  var body: some View {
    Rectangle()
      .frame(width: 4, height: 16)
      .foregroundColor(isStep ? color : .gray)
  }
}

struct AudioBarView_Previews: PreviewProvider {
  static var previews: some View {
    AudioBarView(color: Color(hex: "4CAF50"), isStep: true)
  }
}
