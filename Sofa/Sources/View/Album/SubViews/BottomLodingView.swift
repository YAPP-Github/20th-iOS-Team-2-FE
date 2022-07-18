//
//  BottomLogindView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/18.
//

import SwiftUI

struct BottomLodingView: View {
  var body : some View {
    ProgressView()
      .progressViewStyle(
        CircularProgressViewStyle(tint: Color.init(#colorLiteral(red: 1, green: 0.5433388929, blue: 0, alpha: 1)))
      ).scaleEffect(1.7, anchor: .center)
  }
}

struct BottomLogindView_Previews: PreviewProvider {
  static var previews: some View {
    BottomLodingView()
  }
}
