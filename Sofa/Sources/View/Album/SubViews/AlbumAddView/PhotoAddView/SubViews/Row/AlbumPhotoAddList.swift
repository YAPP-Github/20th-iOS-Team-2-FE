//
//  AlbumPhotoAddList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI

struct AlbumPhotoAddList: View {
  @ObservedObject var photoLibrary = AlbumPhotoLibrary()
  var gridItem = [
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315)),
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315)),
    GridItem(.fixed(UIScreen.main.bounds.width * 0.315))
  ]
    
  var body: some View {
    ScrollView(showsIndicators: false){
      ZStack {
        LazyVGrid(columns: gridItem, spacing: 1) {
          ForEach(0..<photoLibrary.photoAssets.count, id:\.self) { index in
            VStack{
              AlbumPhotoAddRow(photo: photoLibrary.photoAssets[index], index: index)
                .padding(.all, 1)
            }
          }
        }
        .onAppear {
          self.photoLibrary.requestAuthorization()
        }
      }
      .padding(.trailing, 10)
      .padding(.leading, 10)
    }
  }
}

struct AlbumPhotoAddList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumPhotoAddList()
  }
}
