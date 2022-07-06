//
//  AlbumImageDetailView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/28.
//

import SwiftUI

struct AlbumImageDetailView: View {
  @State var touchImage = false
  var image: UIImage
  var index: Int
  
  var body: some View {
    GeometryReader { geometry in // safeAreaInsets.top을 넘겨주기 위해
      ZStack {
        Button(action: {
          touchImage.toggle()
        }) {
          Image(uiImage: image)
          //          .resizable()
            .scaledToFill()
        }
        
        Color("Background")
          .ignoresSafeArea()
          .overlay(
            AlbumImageDetailNavigationBar(safeTop: geometry.safeAreaInsets.top)
              .opacity(touchImage ? 0 : 1) // show/hidden toggle 기능
          )
      }
      .background(Color.black)
      .ignoresSafeArea()
      .navigationBarHidden(true) // 이전 Navigation bar 무시
    }
  }
}

struct AlbumImageDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.elements[6]
    
    AlbumImageDetailView(image: UIImage(named: data.link)!, index: 0)
  }
}
