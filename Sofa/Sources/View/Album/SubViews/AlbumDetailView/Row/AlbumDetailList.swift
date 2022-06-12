//
//  AlbumDetailList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI

struct AlbumDetailList: View {
  @ObservedObject var viewModel = AlbumDetailViewModel()
  
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 10) {
        ForEach(viewModel.posts) { element in
          AlbumDetailRow(isNext: $isNext, info: element)
          AlbumDetailRow(info: element)
        }
      }
    }
  }
}

struct AlbumDetailList_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailList()
    }

class AlbumDetailViewModel : ObservableObject {
  @Published var posts = [AlbumDetailElement]()
  
  init() {
    posts = MockData().albumDetail.elements
  }
}
