//
//  AlbumPhotoAddRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI
import Photos

struct AlbumPhotoAddRow: View {
  @ObservedObject var photo: Asset
  @Binding var imageClick: UIImage?
  var index: Int
  
  var body: some View {
    Button(action: {
      imageClick = photo.image!
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
        Color.black
          .frame(
            width: UIScreen.main.bounds.width * 0.325,
            height: UIScreen.main.bounds.width * 0.325)
          .cornerRadius(5.0)
      }
    })
    .onAppear {
      self.photo.request()
    }
  }
}

struct AlbumPhotoAddRow_Previews: PreviewProvider {
  static var previews: some View {
    let data = UIImage(named: MockData().photoList[1])!
    AlbumPhotoAddRow(photo: Asset(asset: PHAsset()), imageClick: .constant(data), index: 0)
  }
}
