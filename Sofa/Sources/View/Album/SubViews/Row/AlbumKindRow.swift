//
//  AlbumTypeRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import SwiftUI

struct AlbumKindRow: View {
  @Binding var selectKindType: String
  @Binding var showAlbumDetail: Bool
  @Binding var title: String
  var albumKind: AlbumKind
  let info: [String: (String, String, String, Color, Color)] = [
    "favourite": ("즐겨찾기", "bookmark.fill", "장", Color(hex: "#FFD54F"), Color(hex: "#FFF8E1")),
    "photo": ("사진", "photo", "장", Color(hex: "#1192E8"), Color(hex: "#E5F6FF")),
    "recording": ("음성", "waveform", "개", Color(hex: "#66BB6A"), Color(hex: "#E8F5E9"))
  ] // kind: (title, icon, count, backGround, foregroundColor)
  
  var body: some View {
    Button(action: {
      self.title = info[albumKind.kind]!.0
      self.selectKindType = albumKind.kind
      self.showAlbumDetail = true
    }) {
      HStack(alignment:.top, spacing: 16) {
        Rectangle()
          .frame(width: 100.0, height: 75.0)
          .cornerRadius(8)
          .foregroundColor(info[albumKind.kind]!.4)
          .overlay(
            Image(systemName: info[albumKind.kind]!.1)
              .font(.system(size: 32))
              .foregroundColor(info[albumKind.kind]!.3)
          )
        
        VStack(alignment: .leading, spacing: 3) {
          Text(info[albumKind.kind]!.0)
            .font(.custom("Pretendard-Bold", size: 16))
            .foregroundColor(Color(hex: "#121619"))
            .lineLimit(1)
          
          Text("\(albumKind.count)\(info[albumKind.kind]!.2)")
            .font(.custom("Pretendard-Medium", size: 13))
            .foregroundColor(Color(hex: "999999"))
        }
        
        Spacer()
        
        VStack(alignment: .center) {
          Spacer()
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

struct AlbumTypeRow_Previews: PreviewProvider {
  static var previews: some View {
    let dummy = MockData().albumByKind[0]
    
    AlbumKindRow(selectKindType: .constant(""), showAlbumDetail: .constant(false), title: .constant("앨범 상세 유형별"), albumKind: dummy)
  }
}
