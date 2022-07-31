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
  @ObservedObject var listViewModel: AlbumDetailListViewModel

  @Binding var isPhotoThumbnailClick: Bool
  @Binding var isRecordingThumbnailClick: Bool
  @Binding var selectFile: AlbumDetailElement?
  @Binding var selectImage: UIImage
  
  @Binding var isBookmarkClick: Bool
  @Binding var isPhotoCommentClick: Bool
  @Binding var isRecordingCommentClick: Bool
  @Binding var isEllipsisClick: Bool
  
  let info: AlbumDetailElement
  let index: Int
  
  func saveUIImage() {
    DispatchQueue.global().async {
      do {
        if let url = URL(string: selectFile!.link) {
          let data = try Data(contentsOf: url)
          DispatchQueue.main.async {
            self.selectImage = UIImage(data: data)!
          }
        } else {
          self.selectImage = UIImage()
        }
      } catch {
        self.selectImage = UIImage()
      }
    }
  }
  
  var body: some View {
    VStack(spacing: 10) {
      Button(action: {
        selectFile = info
        if info.kind == "PHOTO" {
          saveUIImage()
          isPhotoThumbnailClick = true
        } else {
          isRecordingThumbnailClick = true
        }
      }, label: {
        ZStack(alignment: .topTrailing) {
          // 썸네일
          if info.kind == "PHOTO" {
            if URL(string: info.link) != nil {
              URLImage(url: URL(string: info.link)!, content: { image in
                image
                  .resizable()
                  .frame(height: Screen.maxWidth * 0.7)
                  .cornerRadius(8)
              })
            } else {
              Rectangle()
                .frame(height: Screen.maxWidth * 0.7)
                .cornerRadius(8)
                .foregroundColor(Color(hex: "#FAF8F0"))
                .overlay(
                  Text("이미지를 불러오지 못했습니다")
                    .font(.custom("Pretendard-Regular", size: 16))
                    .foregroundColor(Color.black)
                )
            }
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
          if index == 0 && listViewModel.type == "" {
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
          Text(info.title!)
            .foregroundColor(Color(UIColor.label))
            .font(.system(size: 18, weight: .semibold))
            .padding(.top, -6) // top : 4
          
          Spacer()
        }
      }
      
      HStack {
        Button(action: {
          viewModel.postFavourite()
          if !viewModel.isFavourite { // 즐겨찾기 해제
            isBookmarkClick = true
            listViewModel.albumDetailList[index].favourite = true
          } else if listViewModel.type == "favourite" {
            listViewModel.albumDetailList.remove(at: index)
          } else {
            listViewModel.albumDetailList[index].favourite = false
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
          selectFile = info
          if info.kind == "PHOTO" {
            saveUIImage()
            isPhotoCommentClick = true
          } else {
            isRecordingCommentClick = true
          }
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
          selectFile = info
          if info.kind == "PHOTO" {
            saveUIImage()
          }
        }) {
          Image(systemName: "ellipsis")
            .frame(width: 20, height: 20)
            .foregroundColor(.gray)
            .font(.system(size: 20))
            .padding(.trailing, 4.5)
        }
      }
    }
    .padding([.top, .bottom], 8)
  }
}

struct AlbumDetailRow_Previews: PreviewProvider {
  static var previews: some View {
    let data = MockData().albumDetail.results.elements[3]
    
    AlbumDetailRow(viewModel: AlbumDetailListCellViewModel(fileId: -1, isFavourite: false), listViewModel: AlbumDetailListViewModel(albumId: nil, kindType: nil), isPhotoThumbnailClick: .constant(false), isRecordingThumbnailClick: .constant(false), selectFile: .constant(data), selectImage: .constant(UIImage()), isBookmarkClick: .constant(false), isPhotoCommentClick: .constant(false), isRecordingCommentClick: .constant(false), isEllipsisClick: .constant(false), info: data, index: 0)
  }
}
