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
            EmptyView()
          }
          .opacity(0) // 불투명
          AlbumRow(album: album)
        }
        .listRowBackground(Color.init(hex: "#FAF8F0"))
      }
      .listStyle(PlainListStyle())
      .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
      .background(Color.init(hex: "#FAF8F0"))
      .navigationBarWithButtonStyle("앨범", "plus")
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
