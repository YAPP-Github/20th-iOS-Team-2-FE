//
//  AlbumPhotoAddList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI
import Photos

struct AlbumPhotoAddList: View {
  @StateObject var photoLibrary = AlbumPhotoLibrary()
  @Binding var imageClick: UIImage?
  
  var gridItem = [
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315)),
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315)),
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315))
  ]
  
  var body: some View {
    ScrollView(showsIndicators: true) {
      ZStack {
        LazyVGrid(columns: gridItem, spacing: 1) {
          ForEach(0..<photoLibrary.photoAssets.count, id:\.self) { index in
            VStack{
              AlbumPhotoAddRow(photo: photoLibrary.photoAssets[index], imageClick: $imageClick, index: index)
                .padding(.all, 1)
            }
          }
        }
        .onAppear {
          self.photoLibrary.requestAuthorization()
        }
        .padding(.trailing, 10)
        .padding(.leading, 10)
      }
    }
  }
}

// 임시
//struct LodingView: View {
//  var body: some View {
//    ZStack {
//      Color.black
//        .ignoresSafeArea()
//        .opacity(0.2)
//
//      ProgressView()
//        .progressViewStyle(CircularProgressViewStyle(tint: .black))
//        .scaleEffect(3)
//    }
//  }
//}

struct AlbumPhotoAddList_Previews: PreviewProvider {
  var photoLibrary = AlbumPhotoLibrary()

  static var previews: some View {
    let photoLibrary = AlbumPhotoLibrary()
    
    AlbumPhotoAddList(photoLibrary: photoLibrary, imageClick: .constant(UIImage(named:"photo01")))
      .onAppear {
        let photoList = [Asset](repeating: Asset(asset: PHAsset()), count: 10)

        photoLibrary.photoAssets = photoList
      }
  }
}
