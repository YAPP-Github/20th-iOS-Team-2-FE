//
//  AlbumDetailRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI

struct AlbumDetailRow: View {
  // 이미지
  @Binding var isImageClick: Bool
  @Binding var selectImage: UIImage
  @Binding var selectImageIndex: Int

  @Binding var isBookmarkClick: Bool
  @Binding var isCommentClick: Bool
  @Binding var isEllipsisClick: Bool

  let info: AlbumDetailElement // 임시 @ObservedObject로 변경해야함
  let index: Int
  private var isBookmark : Bool { return info.favourite }
  
  var body: some View {
    VStack(spacing: 10) {
      Button(action: {
        isImageClick = true
        selectImage = UIImage(named: info.link)!
        selectImageIndex = index
      }, label: {
        // post image
        Image(info.link)
          .resizable()
          .frame(height: Screen.maxWidth * 0.7)
          .cornerRadius(8)
      })
      
      if info.type != "PHOTO" { // RECORDING
        HStack {
          Text(info.title!)
            .foregroundColor(Color(UIColor.label))
            .font(.system(size: 18, weight: .semibold))
            .padding(.top, -6) // top : 4
          
          Spacer()
        }
      }
      
      HStack {
        Button(action: {
          isBookmarkClick = true
          selectImageIndex = index
        }) {
          // 북마크
          Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
            .frame(width: 20, height: 20)
            .foregroundColor(isBookmark ? Color(hex: "#FFCA28") : .gray)
            .font(.system(size: 20))
            .padding(.leading, 8)
        }
        
        Button(action: {
          isCommentClick = true
          selectImage = UIImage(named: info.link)!
          selectImageIndex = index
        }, label: {
          HStack(spacing: 8) {
            Image(systemName: "ellipsis.bubble")
              .frame(width: 20, height: 20)
              .foregroundColor(.gray)
              .font(.system(size: 20))
              .padding(.leading, 20)
            
            // 댓글 수
            Text("\(info.commentCount)")
              .foregroundColor(.gray)
              .font(.system(size: 20))
          }
        })
        
        Spacer()
        
        Button(action: {
          isEllipsisClick = true
          selectImageIndex = index
        }) {
          Image(systemName: "ellipsis")
            .frame(width: 20, height: 20)
            .foregroundColor(.gray)
            .font(.system(size: 20))
            .padding(.trailing, 4.5)
        }
      }
    }
  }
}

struct AlbumDetailRow_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.elements[3]
    
    AlbumDetailRow(isImageClick: .constant(false), selectImage: .constant(UIImage(named: data.link)!), selectImageIndex: .constant(0), isBookmarkClick: .constant(false), isCommentClick: .constant(false), isEllipsisClick: .constant(false), info: data, index: 3)
  }
}
