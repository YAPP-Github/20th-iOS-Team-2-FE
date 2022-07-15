//
//  AlbumList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/08.
//

import SwiftUI

struct AlbumList: View {
  @State var albumDate: [AlbumDate]? // 날짜별
  @State var albumType: [AlbumType]? // 유형별
  @State var showDetail = false
  
  var body: some View {
    if let albumDate = albumDate { // 날짜별 보기
      ScrollView(showsIndicators: false) {
        LazyVStack {
          ForEach(albumDate, id: \.self) { album in
            Button(action: {
              showDetail = true
            }, label: {
              AlbumDateRow(album: album)
            })
          }
        }
      }
      .padding(EdgeInsets(top: 0, leading: 16, bottom: 1, trailing: 16)) // 0으로 하면 tabBar area를 무시
      .background(Color.init(hex: "#FAF8F0")) // 임시
    } else if let albumType = albumType { // 유형별 보기
      ScrollView(showsIndicators: false) {
        LazyVStack {
          ForEach(albumType, id: \.self) { album in
            Button(action: {
              showDetail = true
            }, label: {
              AlbumTypeRow(albumTyep: album)
            })
          }
        }
      }
      .padding(EdgeInsets(top: 0, leading: 16, bottom: 1, trailing: 16)) // 0으로 하면 tabBar area를 무시
      .background(Color.init(hex: "#FAF8F0")) // 임시
    }
    
    // 상세 앨범 View로 이동
    NavigationLink("", destination: AlbumDetailView(), isActive: $showDetail)
  }
}

struct AlbumList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumList(albumDate: MockData().albumByDate)
    //    AlbumList(albumType: MockData().albumByType)
  }
}
