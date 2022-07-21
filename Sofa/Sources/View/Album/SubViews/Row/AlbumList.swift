//
//  AlbumList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/08.
//

import SwiftUI
import Introspect

struct AlbumList: View {
  @ObservedObject var viewModel = AlbumListViewModel()
  @StateObject var scrollViewHelper = ScrollViewHelper(threshold: 100)
  @State var showAlbumDetail = false
  @State var selectAlbumId: Int = -1
  @State var selectKindType: String = ""
  let selectType: Int
  
  var body: some View {
    VStack {
      if selectType == 0 { // 날짜별 보기
        ScrollView(showsIndicators: false) {
          PullToRefresh(coordinateSpaceName: "pullToRefresh") {
            viewModel.refreshActionSubject.send()
          }
          
          LazyVStack {
            ForEach(viewModel.albumDateList, id: \.self) { album in
              AlbumDateRow(selectAlbumId: $selectAlbumId, showAlbumDetail: $showAlbumDetail, album: album)
            }
            
            Text("가져올 앨범이 없어요")
              .font(.custom("Pretendard-Medium", size: 16))
              .frame(height: 20)
          }
        }
        .coordinateSpace(name: "pullToRefresh")
        .introspectScrollView(customize: { uiScrollView in
          uiScrollView.delegate = scrollViewHelper
        })
        .onReceive(self.scrollViewHelper.isBottom, perform: { isBottom in
          viewModel.fetchMoreActionSubject.send() // pagenation
        })
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
    NavigationLink("", destination: AlbumDetailView(selectAlbumId: selectAlbumId, selectKindType: selectKindType), isActive: $showAlbumDetail)
  }
}

struct AlbumList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumList(selectType: 0)
  }
}
