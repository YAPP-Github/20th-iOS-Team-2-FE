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
  @State var isSelect: Bool
  @Binding var imageClick: UIImage?
  var index: Int
  let size = UIScreen.main.bounds.width * 0.325
  
  var body: some View {
    ZStack {
      Button(action: {
        imageClick = photo.image!
        isSelect = !isSelect
      }, label: {
        if photo.image != nil {
          Image(uiImage: photo.image!)
            .resizable()
            .scaledToFill()
            .frame(
              width: size,
              height: size,
              alignment: .center)
            .cornerRadius(5.0)
          
        } else {
          Color.black
            .frame(
              width: size,
              height: size)
            .cornerRadius(5.0)
        }
      })
      
      Circle()
        .strokeBorder(Color.white, lineWidth: 1)
        .background(Circle().foregroundColor(isSelect ? Color.init(hex: "#43A047") : Color(UIColor.gray.withAlphaComponent(0.6)))) // 임시 컬러
        .frame(width: 24, height: 24, alignment: .center)
        .offset(x: size/3, y: -(size/3))
    }
    
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
