//
//  AlbumDetailList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI

struct AlbumDetailList: View {
  @ObservedObject var viewModel = AlbumDetailViewModel()
  @Binding var isNext: Bool
  
  var body: some View {
    ScrollView {
      // 필요할때 rendering 함, network에 적합
      LazyVStack(spacing: 10) {
        ForEach(Array(zip(viewModel.posts.indices, viewModel.posts)), id: \.0) { index, element in
          AlbumDetailRow(isNext: $isNext, info: element, index: index)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
      }
    }
  }
}

struct AlbumDetailList_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDetailList(isNext: .constant(false))
  }
}

class AlbumDetailViewModel : ObservableObject {
  @Published var posts = [AlbumDetailElement]()
  
  init() {
    posts = MockData().albumDetail.elements
  }
}
