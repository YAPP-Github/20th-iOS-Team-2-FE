//
//  AlbumDateRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import SwiftUI
import URLImage

struct AlbumDateRow: View {
  @Binding var selectAlbumId: Int
  @Binding var showAlbumDetail: Bool
  @Binding var title: String
  var album: AlbumDate
  
  var body: some View {
    Button(action: {
      self.title = album.title
      self.selectAlbumId = album.albumId
      self.showAlbumDetail = true
    }) {
      HStack(alignment:.top, spacing: 16) { // 위로 붙임
        // 썸네일
        if album.thumbnail == "" {
          Rectangle()
            .frame(width: 100.0, height: 75.0)
            .cornerRadius(8)
            .foregroundColor(Color(hex: "#E8F5E9"))
            .overlay(
              Image(systemName: "waveform")
                .font(.system(size: 32))
                .foregroundColor(Color(hex: "#66BB6A"))
            )
        } else {
          if URL(string: album.thumbnail) != nil {
            URLImage(url: URL(string: album.thumbnail)!, content: { image in
              image
                .resizable()
                .frame(width: 100.0, height: 75.0)
                .cornerRadius(8)
            })
          } else {
            Rectangle()
              .frame(width: 100.0, height: 75.0)
              .cornerRadius(8)
              .foregroundColor(Color(hex: "#FAF8F0"))
              .overlay(
                Text("이미지를 불러오지 못했습니다")
                  .font(.custom("Pretendard-Regular", size: 16))
                  .foregroundColor(Color.black)
              )
          }
        }
        
        // 제목
        VStack(alignment: .leading, spacing: 3) {
          Text(album.title)
            .font(.custom("Pretendard-Bold", size: 16))
            .foregroundColor(Color(hex: "#121619"))
            .lineLimit(2)
          
          Text(album.descriptionDate)
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
    
    AlbumDateRow(selectAlbumId: .constant(0), showAlbumDetail: .constant(false), title: .constant("앨범 상세 날짜별"), album: dummy)
  }
}
