//
//  AlbumPhotoAddRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI

struct AlbumPhotoAddRow: View {
  @ObservedObject var photo: Asset
  var index: Int
  
  var body: some View {
    Button(action: {
      
    }, label: {
      if photo.image != nil {
        Image(uiImage: photo.image!)
          .resizable()
          .scaledToFill()
          .frame(
            width: UIScreen.main.bounds.width * 0.325,
            height: UIScreen.main.bounds.width * 0.325,
            alignment: .center)
          .cornerRadius(5.0)
      } else {
        Color.white
          .frame(
            width: UIScreen.main.bounds.width * 0.325,
            height: UIScreen.main.bounds.width * 0.325)
      }
    })
    .onAppear {
      self.photo.request()
    }
  }
}

//struct AlbumPhotoAddRow_Previews: PreviewProvider {
//  static var previews: some View {
//    UIImage(named: "photo01")?.
//    AlbumPhotoAddRow(photo: AlbumPhotoLibrary().photoAssets[0], index: 0)
//  }
//}
