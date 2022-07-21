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
  var refreshControl: UIRefreshControl {
    let refresh = UIRefreshControl()
    refresh.tintColor = UIColor.red
    return refresh
  }
  
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
        .introspectScrollView(customize: { uiScrollView in
          uiScrollView.delegate = scrollViewHelper
          uiScrollView.refreshControl = refreshControl
        })
        .onReceive(self.scrollViewHelper.isBottom, perform: { isBottom in
          viewModel.fetchMoreActionSubject.send() // pagenation
        })
//        .onReceive(self.scrollViewHelper.isRefresh, perform: { isBottom in
//          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
//            print("리프레시가 되었다")
//            //MARK: - TODO : Api 다시 땡기기
//            viewModel.refreshActionSubject.send()
//            refreshControl.endRefreshing()
//          })
//        })
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
