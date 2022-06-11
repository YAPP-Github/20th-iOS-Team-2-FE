//
//  AlbumPhotoAddView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI

struct AlbumPhotoAddView: View {
  @State var imageClick: UIImage?
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        ZStack {
          Color.black // 배경
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5) // 화면의 반
          
          if imageClick != nil { // 첫 Appear상태에는 선택된 이미지가 없음
            Image(uiImage: imageClick!)
              .resizable()
              .scaledToFit()
              .frame(height: UIScreen.main.bounds.height * 0.5) // 화면의 반
              .padding(.all, 2)
              .pinchToZoom()
          }
        }
        
        ScrollView {
          AlbumPhotoAddList(imageClick: $imageClick)
            .frame(height:UIScreen.main.bounds.height * 0.5)
        }
        .animation(.spring(response: 1, dampingFraction: 0.7, blendDuration: 0))
      }
      .navigationBarInlineStyle(isCancleClick: .constant(true), isNextClick: .constant(true), buttonColor: Color.init(hex: "#43A047"), "사진 선택") // 임시 컬러
    }
  }
}

struct AlbumPhotoAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumPhotoAddView()
  }
}
