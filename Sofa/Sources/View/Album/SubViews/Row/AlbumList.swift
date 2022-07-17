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
  @State var showDateDetail = false
  @State var showKindDetail = false
  
  var body: some View {
    Group {
      if let albumDate = albumDate { // 날짜별 보기
        ScrollView(showsIndicators: false) {
          LazyVStack {
            ForEach(albumDate, id: \.self) { album in
              Button(action: {
                showDateDetail = true
              }, label: {
                AlbumDateRow(album: album)
              })
            }
          }
        }
      } else if let albumType = albumType { // 유형별 보기
        ScrollView(showsIndicators: false) {
          LazyVStack {
            ForEach(albumType, id: \.self) { album in
              Button(action: {
                showKindDetail = true
              }, label: {
                AlbumTypeRow(albumTyep: album)
              })
            }
          }
        }
      }
    }
    .padding([.leading, .trailing], 16)
    .background(Color.init(hex: "#FAF8F0")) // 임시

    // 상세 앨범 View로 이동
    NavigationLink("", destination: AlbumDetailView(), isActive: $showDateDetail)
    NavigationLink("", destination: AlbumDetailView(), isActive: $showKindDetail)
  }
}

struct AlbumList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumList(albumDate: MockData().albumByDate)
    //    AlbumList(albumType: MockData().albumByType)
  }
}
