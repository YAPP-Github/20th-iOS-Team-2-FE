//
//  AlbumRecordAddNavigationBar.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/17.
//

import SwiftUI

struct AlbumRecordAddNavigationBar: View {
  @Environment(\.presentationMode) var presentable
  @Binding var isNext: Bool
  @Binding var existRecord: Bool
  let safeTop: CGFloat
  
  var body: some View {
    VStack {
      VStack {
        Spacer()
        HStack {
          Button(action: {
            presentable.wrappedValue.dismiss()
          }) {
            Text("취소")
              .foregroundColor(Color.white)
          }
          
          Spacer()
          
          Text("새로운 녹음")
            .foregroundColor(Color.white)
          
          Spacer()
          
          Button(action: {
            isNext = true
          }) {
            Text("완료")
              .foregroundColor(existRecord ? Color(hex: "#EC407A"): Color(hex: "#161616"))
          }
          .disabled(!existRecord)
        }
      }
      .font(.custom("Pretendard-Bold", size: 16))
      .frame(height: safeTop + 10)
      .frame(maxWidth: .infinity, alignment: .center)
      .padding(EdgeInsets(top: 20, leading: 24, bottom: 15, trailing: 24))
      .background(Color(hex: "#161616").ignoresSafeArea(edges: .top))
      Spacer()
    }
  }
}

struct AlbumRecordAddNavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    AlbumRecordAddNavigationBar(isNext: .constant(true), existRecord: .constant(true), safeTop: 10)
  }
}
