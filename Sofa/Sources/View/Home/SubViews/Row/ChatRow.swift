//
//  ChatRow.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import SwiftUI

struct ChatRow: View {
  var body: some View {
    HStack(alignment: .top){
      Image("lionprofile")
        .frame(width: 51, height: 52.5)
        .padding(EdgeInsets(top: 10.5, leading: 10.5, bottom: 27, trailing: 14.5))
      VStack(alignment: .leading){
        HStack(){
          Text("별명")
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 8))
          Text("관계")
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0))
          Spacer()
          Text("2시간 전")
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
        LabelView(text: "인사하기 내용이 노출된다. 텍스트의 양이 많아지면 줄바꿈이 되며 그 이상 많아지면 말줄임표로 표현") // Line break word wrap 미적용을 위해
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 16))

      }// VStack
    }// HStack
    .background(Color.white)
    .overlay( // cornerRadius값이 있는 border 주기 위해
      RoundedRectangle(cornerRadius: 8)
          .stroke(Color(hex: "EDEADF"), lineWidth: 1)
    )
    .cornerRadius(8)
    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    
  }
}

struct ChatRow_Previews: PreviewProvider {
  static var previews: some View {
    ChatRow()
  }
}
