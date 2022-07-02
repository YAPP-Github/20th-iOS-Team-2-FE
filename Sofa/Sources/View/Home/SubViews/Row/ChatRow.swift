//
//  ChatRow.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import SwiftUI

struct ChatRow: View {
  
  var member: Member
  
  init(_ member: Member){
    self.member = member
  }
  
  var body: some View {
    HStack(alignment: .top){
      ZStack{
        Image("lionprofile")
          .frame(width: 51, height: 52.5)
        Text("👋")
          .font(.system(size: 20))
          .frame(width: 25, height: 25)
          .offset(x: 20, y: -20)
      }
      .padding(EdgeInsets(top: 10.5, leading: 10.5, bottom: 27, trailing: 14.5))
      VStack(alignment: .leading){
        HStack(){
          Text("\(member.descriptionNickname)")
            .font(.custom("Pretendard-Bold", size: 13))
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 7))
          Text("\(member.descriptionRole)")
            .font(.custom("Pretendard-Regular", size: 12))
            .padding(EdgeInsets(top: 1, leading: 8, bottom: 1, trailing: 8))
            .background(Color(hex: "E8F5E9"))
            .foregroundColor(Color(hex: "43A047"))
            .cornerRadius(4)
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0))
          Spacer()
          Text("\(member.updatedAt)")
            .font(.custom("Pretendard-Regular", size: 13))
            .foregroundColor(Color(hex: "999999"))
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))

        Text("\(member.descriptionContent)")
          .font(.custom("Pretendard-Regular", size: 14))
          .lineLimit(2)
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
    ChatRow(Member.getDummy())
  }
}
