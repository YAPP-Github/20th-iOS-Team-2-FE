//
//  AlbumDateRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import SwiftUI

struct AlbumDateRow: View {
  @Binding var selectAlbumId: Int
  @Binding var showAlbumDetail: Bool
  var album: AlbumDate
  
  var body: some View {
    Button(action: {
      self.selectAlbumId = album.albumId
      self.showAlbumDetail = true
    }) {
      HStack(alignment:.top, spacing: 16) { // 위로 붙임
        // 썸네일
        Image(album.thumbnail)
          .resizable()
          .frame(width: 100.0, height: 75.0)
          .cornerRadius(8)
        
        // 제목
        VStack(alignment: .leading, spacing: 3) {
          Text(album.title == "" ? "\(album.date) 앨범" : album.title)
            .font(.custom("Pretendard-Bold", size: 16))
            .foregroundColor(Color(hex: "#121619"))
            .lineLimit(2)
          
          Text(album.date)
            .font(.custom("Pretendard-Medium", size: 13))
            .foregroundColor(Color(hex: "999999"))
        }
        
        Spacer()
        
        VStack(alignment: .center) {
          Spacer() // icon을 중앙 정렬 시키기 위해
          Image(systemName: "chevron.right")
            .foregroundColor(Color(hex: "999999"))
          Spacer()
        }
      }
      .padding(8)
      .background(Color.white)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color(hex: "EDEADF"), lineWidth: 1)
      )
      .fixedSize(horizontal: false, vertical: true)
      
    }
  }
}

struct AlbumRow_Previews: PreviewProvider {
  static var previews: some View {
    let dummy = MockData().albumByDate[0]
    
    AlbumDateRow(selectAlbumId: .constant(0), showAlbumDetail: .constant(false), album: dummy)
  }
}
