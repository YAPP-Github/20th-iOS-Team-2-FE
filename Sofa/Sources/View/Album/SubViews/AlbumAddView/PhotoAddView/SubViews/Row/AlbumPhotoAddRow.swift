//
//  AlbumPhotoAddRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI

struct AlbumPhotoAddRow: View {
  var photoName: String
  var index: Int
  
  var body: some View {
    Button(action: {
      
    }, label: {
      Image(photoName)
        .resizable()
        .scaledToFill()
        .frame(
          width: UIScreen.main.bounds.width * 0.325,
          height: UIScreen.main.bounds.width * 0.325,
          alignment: .center)
        .cornerRadius(5.0)
    })
  }
}

struct AlbumPhotoAddRow_Previews: PreviewProvider {
  static var previews: some View {
    AlbumPhotoAddRow(photoName: MockData().photoList[0], index: 0)
  }
}
