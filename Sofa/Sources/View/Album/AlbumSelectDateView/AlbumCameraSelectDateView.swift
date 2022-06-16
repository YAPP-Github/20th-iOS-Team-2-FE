//
//  AlbumCameraSelectDateView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/16.
//

import SwiftUI

struct AlbumCameraSelectDateView: View {
  @State var image: UIImage?
  @State var isNext = false
  
  var body: some View {
    NavigationView {
      Text("카메라 날짜 선택 View")
    }
  }
}

struct AlbumCarmeraAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumCameraSelectDateView()
  }
}
