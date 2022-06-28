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
        .frame(height: 52, alignment: .center)
        .shadow(color: Color.black.opacity(0.16), radius: 4, x: 2, y: 3)
        .foregroundColor(Color.white)
        .overlay(
          HStack(spacing: 12){
            Spacer()
            ForEach(["😆", "😭", "😡", "👋", "🎉", "💚"], id: \.self) { item in
              Button {
                print("hi")
              } label: {
                Text(item)
                  .font(.system(size: CGFloat(Int(Screen.maxWidth/13))))
              }
            }
            Image("dividert")
              .frame(width: 0, height: 24, alignment: .center)
            Button {
              print("hi")
              print(Screen.maxWidth)
            } label: {
              Text("💬")
                .font(.system(size: CGFloat(Int(Screen.maxWidth/13))))
            }
            Spacer()
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
