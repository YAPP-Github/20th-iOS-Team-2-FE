//
//  AlbumSelectDateView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import SwiftUI

struct AlbumSelectDateView: View {
  @State var isNext = false
  
  var body: some View {
    NavigationView {
      VStack {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
      }
      .navigationBarWithTextButtonStyle(isNextClick: $isNext, isDisalbeNextButton: .constant(false), "사진 올리기", nextText: "올리기", Color.init(hex: "#43A047"))
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarHidden(true)
  }
}

struct AlbumSelectDateView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumSelectDateView()
  }
}
