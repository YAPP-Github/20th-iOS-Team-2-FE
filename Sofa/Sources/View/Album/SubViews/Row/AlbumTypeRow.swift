//
//  AlbumTypeRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import SwiftUI

struct AlbumTypeRow: View {
  var albumTyep: AlbumType
  let info: [String: (String, String, String, Color, Color)] = [
    "FAVORTIE": ("즐겨찾기", "bookmark", "장", Color(hex: "#FFD54F"), Color(hex: "#FFF8E1")),
    "PHOTO": ("사진", "photo", "장", Color(hex: "#1192E8"), Color(hex: "#E5F6FF")),
    "RECORDING": ("음성", "waveform", "개", Color(hex: "#66BB6A"), Color(hex: "#E8F5E9"))
  ] // kind: (title, icon, count, backGround, foregroundColor)
  
  var body: some View {
    HStack(alignment:.top, spacing: 8) {
      Rectangle()
        .frame(width: 100.0, height: 75.0)
        .cornerRadius(8)
        .foregroundColor(info[albumTyep.kind]!.4)
        .overlay(
          Image(systemName: info[albumTyep.kind]!.1)
            .font(.system(size: 32))
            .foregroundColor(info[albumTyep.kind]!.3)
        )
      
      VStack(alignment: .leading, spacing: 3) {
        Text(info[albumTyep.kind]!.0)
          .font(.system(size: 16, weight: .semibold))
          .lineLimit(1)

        Text("\(albumTyep.count)\(info[albumTyep.kind]!.2)")
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      
      Spacer()
      
      VStack(alignment: .center) {
        Spacer()
        Image(systemName: "chevron.right")
          .foregroundColor(.gray)
        Spacer()
      }
    }
    .padding(8)
    .background(Color.white)
    .cornerRadius(12)
    .fixedSize(horizontal: false, vertical: true)
    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // 임시
  }
}

struct AlbumTypeRow_Previews: PreviewProvider {
  static var previews: some View {
    let dummy = MockData().albumByType[0]
    
    AlbumTypeRow(albumTyep: dummy)
  }
}
