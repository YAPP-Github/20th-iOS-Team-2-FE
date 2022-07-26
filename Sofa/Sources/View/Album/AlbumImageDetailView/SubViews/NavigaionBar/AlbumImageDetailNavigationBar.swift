//
//  AlbumImageDetailNavigationBar.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/06.
//

import SwiftUI

struct AlbumImageDetailNavigationBar: View {
  @Environment(\.presentationMode) var presentable
  let safeTop: CGFloat
  
  var body: some View {
    VStack {
      Button(action: {
        presentable.wrappedValue.dismiss()
      }) {
        VStack {
          Spacer()
          HStack(spacing: 4) {
            Image(systemName: "chevron.left")
              .font(.system(size: 20))
            Text("이전")
              .font(.custom("Pretendard-Medium", size: 16))
          }
        }
      }
      .foregroundColor(Color.white)
      .frame(height: safeTop + 10)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(EdgeInsets(top: 20, leading: 24, bottom: 15, trailing: 0))
      .background(Blur(style: .systemUltraThinMaterial).ignoresSafeArea(edges: .top))
      Spacer()
    }
  }
}

struct AlbumImageDetailNavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    AlbumImageDetailNavigationBar(safeTop: 10)
  }
}
