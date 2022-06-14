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
  private var isBookmark : Bool { return info.favourite }
  
  var body: some View {
    Button(action: {
      isNext = true
    }, label: {
      VStack(spacing: info.type != "PHOTO" ? 10 : 4) {
        // post image
        Image(info.link)
          .resizable()
          .frame(height: Screen.maxWidth * 0.7)
          .cornerRadius(8)
        
        
        if info.type != "PHOTO" { // RECORDING
          HStack {
            Text(info.title!)
              .foregroundColor(Color(UIColor.label))
              .font(.system(size: 18, weight: .semibold))
            
            Spacer()
          }
        }
        
        HStack {
          HStack(spacing: 3) {
            Image(systemName: "ellipsis.bubble")
              .frame(width: 20, height: 20)
              .foregroundColor(.gray)
              .font(.system(size: 20))
              .padding(4)
            
            // 댓글 수
            Text("\(info.commentCount)")
              .foregroundColor(.gray)
              .font(.system(size: 20))
          }
          .padding(EdgeInsets(top: 0, leading: 49, bottom: 0, trailing: 0))
          
          Spacer()
        }
      }
    })
    .overlay (
      HStack(spacing: 16) {
        Button(action: {
          print("bookmark click")
        }) {
          // 북마크
          Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
            .frame(width: 20, height: 20)
            .foregroundColor(isBookmark ? Color(hex: "#FFCA28") : .gray)
            .font(.system(size: 20))
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
        }
        
        Spacer()
        
        Button(action: {
        }) {
          Image(systemName: "ellipsis")
            .frame(width: 20, height: 20)
            .foregroundColor(.gray)
            .font(.system(size: 20))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
        }
      }.offset(y: info.type == "PHOTO" ? 140 : 158) // image위에 icon button 올려놓기
    )
  }
}

struct AlbumDetailRow_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.elements[3]
    
    AlbumDetailRow(isNext: .constant(false), info: data)
  }
}
