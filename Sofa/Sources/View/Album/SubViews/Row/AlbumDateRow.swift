//
//  AlbumDateRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import SwiftUI

struct AlbumDateRow: View {
  var album: Album
  
  var body: some View {
    HStack(alignment:.top, spacing: 8) { // 위로 붙임
      // 썸네일
      Image(album.thumbnail)
        .resizable()
        .frame(width: 100.0, height: 75.0)
        .cornerRadius(8)
      
      // 제목
      VStack(alignment: .leading, spacing: 3) {
        Text(album.title == "" ? "\(album.date) 앨범" : album.title)
          .font(.system(size: 16, weight: .semibold))
          .foregroundColor(Color.black)
          .lineLimit(2)
        
        Text(album.date)
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      
      Spacer()
      
      VStack(alignment: .center) {
        Spacer() // icon을 중앙 정렬 시키기 위해
        Image(systemName: "chevron.right")
          .foregroundColor(.gray)
        Spacer()
      }
    }
    .padding(8)
    .background(Color.white)
    .cornerRadius(12)
    .fixedSize(horizontal: false, vertical: true)
  }
}

struct AlbumRow_Previews: PreviewProvider {
  static var previews: some View {
    let dummy = MockData().albumByDate[0]
    
    AlbumDateRow(album: dummy)
  }
}
