//
//  AlbumDetailRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/13.
//

import SwiftUI
import URLImage

struct AlbumDetailRow: View {
  @ObservedObject var viewModel: AlbumDetailListCellViewModel

  // 이미지
  @Binding var isImageClick: Bool
  @Binding var selectImage: UIImage
  @Binding var selectImageIndex: Int
  
  @Binding var isBookmarkClick: Bool
  @Binding var isCommentClick: Bool
  @Binding var isEllipsisClick: Bool
  
  let info: AlbumDetailElement
  let index: Int
  
  var body: some View {
    VStack(spacing: 10) {
      Button(action: {
        isImageClick = true
        selectImage = UIImage(named: info.link)!
        selectImageIndex = index
      }, label: {
        ZStack(alignment: .topTrailing) {
          // 썸네일
          if info.kind == "PHOTO" {
            URLImage(url: URL(string: info.link)!, content: { image in
              image
                .resizable()
                .frame(height: Screen.maxWidth * 0.7)
                .cornerRadius(8)
            })
          } else {
            Rectangle()
              .cornerRadius(8)
              .frame(height: Screen.maxWidth * 0.7)
              .foregroundColor(Color(hex: "#E8F5E9"))
              .overlay(
                Image(systemName: "waveform")
                  .font(.system(size: 32))
                  .foregroundColor(Color(hex: "#66BB6A"))
              )
          }
          
          // 대표 사진 Badge
          if index == 0 && info.kind == "PHOTO" {
            Group {
              Text("대표 사진")
                .font(.custom("Pretendard-Bold", size: 12))
                .foregroundColor(Color.black)
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .background(Color.white)
                .cornerRadius(4)
            }
            .padding([.top, .trailing], 8)
          }
        }
      })
      
      if info.kind == "RECORDING" { // RECORDING
        HStack {
          Text("녹음 제목")
            .foregroundColor(Color(UIColor.label))
            .font(.system(size: 18, weight: .semibold))
            .padding(.top, -6) // top : 4
          
          Spacer()
        }
      }
      
      HStack {
        Button(action: {
          viewModel.fetchAlbumDetailByDate()
          if !viewModel.isFavourite {
            isBookmarkClick = true
          }
        }) {
          // 북마크
          Image(systemName: viewModel.isFavourite ? "bookmark.fill" : "bookmark")
            .frame(width: 20, height: 20)
            .foregroundColor(viewModel.isFavourite ? Color(hex: "#FFCA28") : .gray)
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
    .padding(.bottom, 10)
  }
}

struct AlbumDetailRow_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.results.elements[3]
    
    AlbumDetailRow(viewModel: AlbumDetailListCellViewModel(fileId: -1, isFavourite: false), isImageClick: .constant(false), selectImage: .constant(UIImage(named: data.link)!), selectImageIndex: .constant(0), isBookmarkClick: .constant(false), isCommentClick: .constant(false), isEllipsisClick: .constant(false), info: data, index: 0)
  }
}
