//
//  EmojiView.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/28.
//

import SwiftUI

struct EmojiView: View {
  var body: some View {
    HStack{
      Capsule()
        .frame(width: 344, height: 52, alignment: .center)
        .shadow(color: Color.black.opacity(0.16), radius: 4, x: 2, y: 3)
        .foregroundColor(Color.white)
        .overlay(
          HStack(spacing: 12){
            Group{
              Text("😆")
              Text("😭")
              Text("😡")
              Text("👋")
              Text("🎉")
              Text("💚")
            }
            .frame(width: 32, height: 32, alignment: .center)
            Image("dividert")
              .frame(width: 0, height: 24, alignment: .center)
            Text("💬")
              .frame(width: 32, height: 32, alignment: .center)
          }
        )
        .overlay( // cornerRadius값이 있는 border 주기 위해
          RoundedRectangle(cornerRadius: 30)
            .stroke(Color(hex: "EDEADF"), lineWidth: 1)
        )
    }
  }
}

struct EmojiView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiView()
  }
}
