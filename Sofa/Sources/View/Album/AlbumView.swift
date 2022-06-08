//
//  AlbumView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct AlbumView: View {
  @State var albums = [Album]()
  
  var body: some View {
    NavigationView {
      List(albums, id: \.albumId) { album in
        ZStack {
          NavigationLink(destination: AlbumDetailView()) {
          }
          AlbumRow(album: album)
        }
      }
      .background(Color.red)
      .navigaionBarWithButtonStyle("앨범")
    }
  }
}

struct AlbumView_Previews: PreviewProvider {
  static var previews: some View {
    let albums = [
      Album(albumId: 0, title: "2022-12-25 앨범", thumbnail: "", date: "2022-06-05"),
      Album(albumId: 1, title: "제주도 가족여행", thumbnail: "", date: "2022-05-28"),
      Album(albumId: 2, title: "여의도 공원 나드리", thumbnail: "", date: "2022-05-28")
    ]
    AlbumView(albums: albums)
  }
}
