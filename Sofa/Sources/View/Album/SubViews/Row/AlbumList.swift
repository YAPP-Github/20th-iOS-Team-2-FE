//
//  AlbumList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/08.
//

import SwiftUI

struct AlbumList: View {
  @State var albumDate: [Album]? // 날짜별
  @State var albumType: [AlbumType]? // 유형별
  
  var body: some View {
    if let albumDate = albumDate {
      List(albumDate, id: \.albumId) { album in
        ZStack {
          NavigationLink(destination: AlbumDetailView()) {
            EmptyView()
          }
          .opacity(0) // 불투명
          AlbumRow(album: album)
        }
        .listRowBackground(Color.init(hex: "#FAF8F0")) // 임시
      }
      .listStyle(PlainListStyle())
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
      .background(Color.init(hex: "#FAF8F0")) // 임시
    } else if let albumType = albumType {
      List(albumType, id: \.self) { album in
        ZStack {
          NavigationLink(destination: AlbumDetailView()) {
            EmptyView()
          }
          .opacity(0) // 불투명
          AlbumTypeRow(albumTyep: album)
        }
        .listRowBackground(Color.init(hex: "#FAF8F0")) // 임시
      }
      .listStyle(PlainListStyle())
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
      .background(Color.init(hex: "#FAF8F0")) // 임시
      
    }
  }
}

struct AlbumList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumList(albumDate: MockData().albumByDate)
    //    AlbumList(albumType: MockData().albumByType)
  }
}
