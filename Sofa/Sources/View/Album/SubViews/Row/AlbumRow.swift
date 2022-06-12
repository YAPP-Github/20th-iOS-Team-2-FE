//
//  AlbumRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import SwiftUI

struct AlbumRow: View {
  var album: Album
  
  var body: some View {
    HStack(alignment:.top, spacing: 8) {
      Image(album.thumbnail)
        .resizable()
        .frame(width: 100.0, height: 75.0)
        .cornerRadius(8)
      
      VStack(alignment: .leading, spacing: 3) {
        Text(album.title)
          .lineLimit(1)
        
        Text(album.date)
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      
      Spacer()
      
      VStack(alignment: .center) {
        Spacer()
        Image(systemName: "chevron.right")
          .font(.body)
        Spacer()
      }
    }
    .padding(8)
    .background(Color.white)
    .cornerRadius(12)
    .fixedSize(horizontal: false, vertical: true)
    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // 임시
  }
}

struct AlbumRow_Previews: PreviewProvider {
  static var previews: some View {
    let dummy = MockData().photoList[0]
    
    let album0 = Album(albumId: 0, title: "제주도 가족여행 제주도 가족여행 제주도 가족여행", thumbnail: dummy, date: "2022-05-28")
    AlbumRow(album: album0)
  }
}
