//
//  AlbumDetailRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI

struct AlbumDetailRow: View {
  @Binding var isNext: Bool
  let info: AlbumDetailElement // 임시 @ObservedObject로 변경해야함
  private  let screen = UIScreen.main.bounds
  private  var isBookmark : Bool { return info.favourite }
  
  var body: some View {
    Button(action: {
      isNext = true
    }, label: {
      VStack() {
        Image(info.link)
          .resizable()
          .frame(height: screen.width * 0.7)
        
        HStack(spacing: 16) {
          
          HStack(spacing: 0) {
            Image(systemName: "ellipsis.bubble")
              .frame(width: 20, height: 20)
              .foregroundColor(.gray)
              .font(.system(size: 20))
              .padding(4)
            
            Text("\(info.commentCount)")
              .foregroundColor(.gray)
              .font(.system(size: 20))
              .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
          }
          .padding(EdgeInsets(top: 0, leading: 56, bottom: 0, trailing: 0))
          
          Spacer()
        }
      }
    })
    .overlay (
      HStack(spacing: 16) {
        Button(action: {
          print("bookmark click")
        }) {
          Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
            .frame(width: 20, height: 20)
            .foregroundColor(isBookmark ? Color(hex: "#FFCA28") : .gray)
            .font(.system(size: 20))
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
        
        Spacer()
        
        Button(action: {
          print("점 3개 click")
        }) {
          Image(systemName: "ellipsis")
            .frame(width: 20, height: 20)
            .foregroundColor(.gray)
            .font(.system(size: 20))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
      }.offset(y: 140)
    )
  }
}

struct AlbumDetailRow_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.elements[1]
    
    AlbumDetailRow(isNext: .constant(false), info: data)
  }
}
