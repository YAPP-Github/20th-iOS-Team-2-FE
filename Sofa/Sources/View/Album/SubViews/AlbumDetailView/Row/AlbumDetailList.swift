//
//  AlbumDetailList.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI

struct AlbumDetailList: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  @ObservedObject var viewModel = AlbumDetailViewModel()
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
