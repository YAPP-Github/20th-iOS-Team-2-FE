//
//  EmojiView.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/28.
//

import SwiftUI
import ConfettiSwiftUI

struct EmojiView: View {
  
  @State private var counter1: Int = 0
  @State private var counter2: Int = 0
  @State private var counter3: Int = 0
  @State private var counter4: Int = 0
  @State private var counter5: Int = 0
  @State private var counter6: Int = 0

  var body: some View {
    HStack{
      Capsule()
        .frame(height: 52, alignment: .center)
        .shadow(color: Color.black.opacity(0.16), radius: 4, x: 2, y: 3)
        .foregroundColor(Color.white)
        .overlay(
          HStack(spacing: 12){
            Spacer()
            Group{
              Button {
                counter1 += 1
              } label: {
                Text("😆")
                  .font(.system(size: CGFloat(Int(Screen.maxWidth/13))))
              }
              .confettiCannon(counter: $counter1, num: 20,confettis: [.text("😆")], confettiSize: 20, rainHeight: 500, radius: 350)
              Button {
                counter2 += 1
              } label: {
                Text("😭")
                  .font(.system(size: CGFloat(Int(Screen.maxWidth/13))))
              }
              .confettiCannon(counter: $counter2, num: 20,confettis: [.text("😭")], confettiSize: 20, rainHeight: 500, radius: 350)
              Button {
                counter3 += 1
              } label: {
                Text("😡")
                  .font(.system(size: CGFloat(Int(Screen.maxWidth/13))))
              }
              .confettiCannon(counter: $counter3, num: 20,confettis: [.text("😡")], confettiSize: 20, rainHeight: 500, radius: 350)
              Button {
                counter4 += 1
              } label: {
                Text("👋")
                  .font(.system(size: CGFloat(Int(Screen.maxWidth/13))))
              }
              .confettiCannon(counter: $counter4, num:20,confettis: [.text("👋")], confettiSize: 20, rainHeight: 500, radius: 350)
              Button {
                counter5 += 1
              } label: {
                Text("🎉")
                  .font(.system(size: CGFloat(Int(Screen.maxWidth/13))))
              }
              .confettiCannon(counter: $counter5, num: 20,confettis: [.text("🎉")], confettiSize: 20, rainHeight: 500, radius: 350)
              Button {
                counter6 += 1
              } label: {
                Text("💚")
                  .font(.system(size: CGFloat(Int(Screen.maxWidth/13))))
              }
              .confettiCannon(counter: $counter6, num: 20,confettis: [.text("💚")], confettiSize: 20, rainHeight: 500, radius: 350)
            } // Emoji Button Group

            Image("dividert")
              .frame(width: 0, height: 24, alignment: .center)
            Button {
              print("hi")
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
