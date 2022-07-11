//
//  AlbumCommentRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/10.
//

import SwiftUI

struct AlbumCommentRow: View {
  var comment: Comment

  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      Image("lionprofile") // 이미지
        .resizable()
        .frame(width: 48, height: 48)
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
      
      VStack(alignment: .leading) { // 댓글 정보
        HStack(alignment: .center, spacing: 8) { // 댓글 작성자 정보
          Text("\(comment.nickname)") // 별명
            .font(.custom("Pretendard-Bold", size: 13))
          
          Text("\(comment.roleInFamily)") // 역할
            .font(.custom("Pretendard-Medium", size: 12))
            .padding(EdgeInsets(top: 1, leading: 8, bottom: 1, trailing: 8))
            .background(Color(hex: "E8F5E9"))
            .foregroundColor(Color(hex: "43A047"))
            .cornerRadius(4)
          
          Spacer()
          
          Text("\(comment.descriptionDate)") // 날짜
            .font(.custom("Pretendard-Medium", size: 13))
            .foregroundColor(Color.secondary)
            .padding(.trailing, 16)
        }
        
        Text("\(comment.descriptionContent)") // 댓글
          .font(.custom("Pretendard-Medium", size: 14))
          .lineSpacing(5)
      }
    }
    .padding([.bottom], 24)
  }
}

struct AlbumCommentRow_Previews: PreviewProvider {
  static var previews: some View {
    AlbumCommentRow(comment: Comment.getDummy())
  }
}
