//
//  AlbumPhotoAddView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI

struct AlbumPhotoAddView: View {
  @State private var isTabPhoto = false
  @State var selectImage: UIImage = UIImage(named: MockData().photoList[0])!
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        Color.black // 배경
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5) // 화면의 반
        Image(uiImage: selectImage)
          .resizable()
          .scaledToFit()
          .frame(height: UIScreen.main.bounds.height * 0.5) // 화면의 반
          .padding(.all, 2)
      }
      ScrollView {
        AlbumPhotoAddList(selectImage: $selectImage)
          .frame(height:UIScreen.main.bounds.height * 0.5)
      }
      .animation(.spring(response: 1, dampingFraction: 0.7, blendDuration: 0))
    }
  }
}

struct AlbumPhotoAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumPhotoAddView()
  }
}
