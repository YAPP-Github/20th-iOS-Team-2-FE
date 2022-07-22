//
//  AlbumImageDetailSettingBar.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/07.
//

import SwiftUI

struct AlbumImageDetailSettingBar: View {
  @Binding var isBookmarkClick: Bool
  @Binding var isCommentClick: Bool
  @Binding var isEllipsisClick: Bool

  let info: AlbumDetailElement // 임시 @ObservedObject로 변경해야함
  private var isBookmark : Bool { return info.favourite }
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
        VStack {
          HStack {
            Button(action: {
              // 북마크 네트워크 로직
              self.isBookmarkClick = true
            }) {
              // 북마크
              Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
                .frame(width: 20, height: 20)
                .foregroundColor(isBookmark ? Color(hex: "#FFCA28") : .white)
                .font(.system(size: 20))
                .padding(.leading, 8)
            }
            
            Button(action: {
              // NetWork
              isCommentClick = true
            }, label: {
              HStack(spacing: 8) {
                Image(systemName: "ellipsis.bubble")
                  .frame(width: 20, height: 20)
                  .foregroundColor(.white)
                  .font(.system(size: 20))
                  .padding(.leading, 20)
                
                // 댓글 수
                Text("\(info.commentCount)")
                  .foregroundColor(.white)
                  .font(.system(size: 20))
              }
            })
            
            Spacer()
            
            Button(action: {
              isEllipsisClick = true
            }) {
              Image(systemName: "ellipsis")
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .font(.system(size: 20))
            }
          }
          .padding(EdgeInsets(top: 12, leading: 12, bottom: 15, trailing: 16))
          Spacer()
        }
        .frame(height: 83)
        .background(Blur(style: .systemUltraThinMaterial).ignoresSafeArea(edges: .bottom))
      }
    }
  }
}

struct AlbumImageDetailSettingBar_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.elements[3]
    
    AlbumImageDetailSettingBar(isBookmarkClick: .constant(false), isCommentClick: .constant(false), isEllipsisClick: .constant(false), info: data)
      .ignoresSafeArea()
  }
}
