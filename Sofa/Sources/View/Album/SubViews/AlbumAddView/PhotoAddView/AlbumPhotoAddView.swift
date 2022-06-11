//
//  AlbumPhotoAddView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI

struct AlbumPhotoAddView: View {
  @State private var isTabPhoto = false

  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ZStack {
          Color.black // 배경
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2) // 화면의 반
          Image("photo01")
            .resizable()
            .scaledToFit()
            .frame(height: UIScreen.main.bounds.height/2) // 화면의 반
            .padding(.all, 2)
        }
        AlbumPhotoAddList()
      }
    }
    .animation(.spring(response: 1, dampingFraction: 0.7, blendDuration: 0))
  }
}

struct AlbumPhotoAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumPhotoAddView()
  }
}
