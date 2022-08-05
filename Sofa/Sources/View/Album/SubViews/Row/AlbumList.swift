//
//  AlbumList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/08.
//

import SwiftUI
import Introspect

struct AlbumList: View {
  @ObservedObject var viewModel: AlbumListViewModel
  @StateObject var scrollViewHelper = ScrollViewHelper(threshold: 100)
  @State var title: String = "앨범 상세"
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
              AlbumDateRow(selectAlbumId: $selectAlbumId, showAlbumDetail: $showAlbumDetail, title: $title, album: album)
            }
            
            if viewModel.albumDateList.count == 0 {
              Image("empty1")
                .resizable()
                .scaledToFit()
                .padding(.top, 16)
                .padding([.leading, .trailing], 25)
              
              Text("아직 앨범에 파일이 없습니다")
                .font(.custom("Pretendard-Medium", size: 18))
                .foregroundColor(Color(hex: "999999"))
            } else {
              Text("앨범의 마지막이예요")
                .font(.custom("Pretendard-Medium", size: 16))
                .foregroundColor(Color(hex: "999999"))
                .padding(.top, 16)
            }
          }
          
          // 상세 앨범 View로 이동
          NavigationLink("", destination: AlbumDetailView(listViewModel: AlbumDetailListViewModel(albumId: selectAlbumId, kindType: nil), title: title, selectAlbumId: selectAlbumId), isActive: $showAlbumDetail)
        }
        .offset(y: -10) // PullToRefresh로 인해 scrollview위로 올리기
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
              AlbumKindRow(selectKindType: $selectKindType, showAlbumDetail: $showAlbumDetail, title: $title, albumKind: kind)
            }
          }
          
          // 상세 앨범 View로 이동
          NavigationLink("", destination: AlbumDetailView(listViewModel: AlbumDetailListViewModel(albumId: nil, kindType: selectKindType), title: title, selectKindType: selectKindType), isActive: $showAlbumDetail)
        }
      }
    }
    .padding([.leading, .trailing], 16)
    .onAppear {
      self.viewModel.refreshActionSubject.send()
    }
  }
}

struct AlbumList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumList(viewModel: AlbumListViewModel(), selectType: 0)
  }
}
