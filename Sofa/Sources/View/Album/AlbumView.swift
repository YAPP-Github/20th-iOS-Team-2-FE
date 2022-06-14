//
//  AlbumView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct AlbumView: View {
  @State var albums = [Album]()
  @State var types = [Album]()
  @State var selected = 0
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        Picker(selection: $selected, label: Text(""), content: {
          Text("날짜별").tag(0)
          Text("유형별").tag(1)
        })
        .padding()
        .background(Color.init(hex: "#FAF8F0")) // 임시
        .pickerStyle(SegmentedPickerStyle())
        .navigationBarWithButtonStyle("앨범", "plus")
        
        if selected == 0 {
          AlbumList(albums: albums)
        } else if selected == 1 {
          AlbumList(albums: types)
        }
      }
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
    
    let type = [
      Album(albumId: 0, title: "즐겨찾기", thumbnail: "", date: "2022-06-05"),
      Album(albumId: 1, title: "제주도 가족여행", thumbnail: "", date: "2022-05-28"),
    ]
    AlbumView(albums: albums, types: type)
  }
}
