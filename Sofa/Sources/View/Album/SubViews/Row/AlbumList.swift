//
//  AlbumList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/08.
//

import SwiftUI

struct AlbumList: View {
  @State var albumDate: [AlbumDate]? // 날짜별
  @State var albumKind: [AlbumKind]? // 유형별
  @ObservedObject var viewModel = AlbumListViewModel()
  @State var showAlbumDetail = false
  @State var selectAlbumId: Int = -1
  @State var selectKindType: String = ""
  let selectType: Int
  
  var body: some View {
    VStack {
      if selectType == 0 { // 날짜별 보기
        ScrollView(showsIndicators: false) {
          LazyVStack {
            ForEach(viewModel.albumDateList, id: \.self) { album in
              AlbumDateRow(selectAlbumId: $selectAlbumId, showAlbumDetail: $showAlbumDetail, album: album)
            }
          }
        }
      } else if selectType == 1 { // 유형별 보기
        ScrollView(showsIndicators: false) {
          LazyVStack {
            ForEach(viewModel.albumKindList, id: \.self) { kind in
              AlbumKindRow(selectKindType: $selectKindType, showAlbumDetail: $showAlbumDetail, albumKind: kind)
            }
          }
        }
      }
    }
    .padding([.leading, .trailing], 16)
    
    // 상세 앨범 View로 이동
    NavigationLink("", destination: AlbumDetailView(), isActive: $showAlbumDetail)
  }
}

struct AlbumList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumList(selectType: 0)
  }
}
