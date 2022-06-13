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
        ForEach(viewModel.posts) { element in
          AlbumDetailRow(isNext: $isNext, info: element)
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
