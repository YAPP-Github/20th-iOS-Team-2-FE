//
//  AlbumRecordAddView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI

struct AlbumRecordAddView: View {
  
  var body: some View {
    NavigationView {
      
        .navigationBarOnlyCancelButtonStyle("새로운 녹음")
    }
  }
}

struct AlbumRecordAddView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumRecordAddView()
  }
}
