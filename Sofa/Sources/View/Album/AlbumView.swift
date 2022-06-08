//
//  AlbumView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct AlbumView: View {
  var body: some View {
    NavigationView {
      ScrollView {
        
          AlbumRow(album: album)
      }
      .background(Color.red)
      .navigaionBarWithButtonStyle("앨범")
    }
  }
}

struct AlbumView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumView()
  }
}
