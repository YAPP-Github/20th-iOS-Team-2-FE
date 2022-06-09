//
//  AlbumPhotoAddList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI

struct AlbumPhotoAddList: View {
  let photoList: [String]
  var gridItem = [
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315)),
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315)),
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315))
  ]
  
  var body: some View {
    ScrollView(showsIndicators: false){
      LazyVGrid(columns: gridItem, spacing: 1) {
        ForEach(0..<photoList.count, id:\.self) { index in
          VStack{
            AlbumPhotoAddRow(photoName: photoList[index], index: index)
              .padding(.all, 1)
          }
        }
      }
      .padding(.trailing, 10)
      .padding(.leading, 10)
    }
  }
}

struct AlbumPhotoAddList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumPhotoAddList(photoList: MockData().photoList)
  }
}
