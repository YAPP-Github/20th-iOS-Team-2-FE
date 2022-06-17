//
//  AudioBarView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/17.
//

import SwiftUI

struct AudioBarView: View {
  var color: Color
  var value: Bool
  
  var body: some View {
    ZStack{
      Rectangle()
        .frame(width: 4, height: 16)
        .foregroundColor(value ? color : .gray)
    }
  }
}

struct AudioBarView_Previews: PreviewProvider {
  static var previews: some View {
    AudioBarView(color: Color(hex: "4CAF50"), value: true)
  }
}
