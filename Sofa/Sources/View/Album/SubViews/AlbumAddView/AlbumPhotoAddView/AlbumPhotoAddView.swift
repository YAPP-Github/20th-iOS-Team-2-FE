//
//  AlbumPhotoAddView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI
import Photos

struct AlbumPhotoAddView: View {
  @State var isNext = false
  @State var imageClick: UIImage?
  @State var selected : [SelectedImages] = []
  private let height = Screen.maxWidth * 0.8
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        ZStack {
          Color.black // 배경
            .frame(width: Screen.maxWidth, height: height) // 화면의 반
          
          if imageClick != nil { // 첫 Appear상태에는 선택된 이미지가 없음
            Image(uiImage: imageClick!)
              .resizable()
              .scaledToFit()
              .frame(height: height) // 화면의 반
              .padding(.all, 2)
              .pinchToZoom()
          }
        }
        
        AlbumPhotoAddList(selected: $selected, imageClick: $imageClick)
          .frame(height: Screen.maxHeight * 0.5)
        //          .animation(.spring(response: 1, dampingFraction: 0.7, blendDuration: 0)) // 임시
        
        // 날짜 선택으로 이동
        NavigationLink("", destination: AlbumSelectDateView(), isActive: $isNext)
      }
      .navigationBarInlineStyle(isNextClick: $isNext, isDisalbeNextButton: .constant(selected.isEmpty), buttonColor: Color.init(hex: "#43A047"), "사진 선택") // 임시 컬러
    }
  }
}

struct AlbumPhotoAddView_Previews: PreviewProvider {
  static var previews: some View {
    let data = UIImage(named: MockData().photoList[0])!
    let selectedImage = SelectedImages(asset: PHAsset(), image: data)
    
    AlbumPhotoAddView(imageClick: data, selected: [selectedImage])
  }
}
