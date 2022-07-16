//
//  AlbumTitleEditNavigationBar.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/15.
//

import SwiftUI
import Combine

struct AlbumTitleEditNavigationBar: View {
  @State var firstResponder: FirstResponders? = Sofa.FirstResponders.text
  @Binding var title: String
  let paddingValue: CGFloat = 12
  let safeTop: CGFloat
  
  var body: some View {
    VStack {
      VStack {
        Spacer()
        ZStack {
          TextField("앨범 제목", text: $title)
            .firstResponder(id: FirstResponders.text, firstResponder: $firstResponder, resignableUserOperations: .none)
            .font(.custom("Pretendard-Medium", size: 18))
            .customTextField(padding: paddingValue)
            .disableAutocorrection(true)
            .background(Color.white) // 입력 Area 색상
            .cornerRadius(6)
            .highlightTextField(firstLineWidth: 1, secondLineWidth: 4)
          
          // 아이콘 X
          HStack{
            Spacer()
            Image(systemName: "xmark")
              .font(.system(size: 20))
              .foregroundColor(Color.black.opacity(!title.isEmpty ? 0.4 : 0))
              .padding(.trailing, 13.5)
              .contentShape(Rectangle())
              .onTapGesture {
                title = ""
              }
          }
        }
      }
      .frame(height: safeTop + 10 + paddingValue)
      .frame(maxWidth: .infinity, alignment: .center)
      .padding(EdgeInsets(top: 20 + paddingValue, leading: 16, bottom: 15, trailing: 16))
      .background(Color.white.ignoresSafeArea(edges: .top))
      Spacer()
    }
  }
}

struct AlbumTitleEditNavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    AlbumTitleEditNavigationBar(title: .constant(""), safeTop: 10)
  }
}
