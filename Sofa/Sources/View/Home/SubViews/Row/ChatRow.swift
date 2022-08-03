//
//  ChatRow.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import SwiftUI


struct ChatRow: View {
  
  var member: ChatMember
  var callback: (() -> Void)?
  
  var emojiDict = [1 : "😆", 2: "😭", 3: "😡", 4: "👋", 5: "🎉", 6: "💚"]
  
  
  init(_ member: ChatMember, callback: (() -> Void)?){
    self.member = member
    self.callback = callback
  }
  
  var body: some View {
    HStack(alignment: .top){
      ZStack{
        Image("lionprofile")
          .resizable()
          .frame(width: 51, height: 52.5)
        Text("\(emojiDict[member.emoji] ?? "")")
          .font(.system(size: 20))
          .frame(width: 25, height: 25)
          .offset(x: 20, y: -20)
      }
      .padding(EdgeInsets(top: 10.5, leading: 10.5, bottom: 27, trailing: 14.5))
      VStack(alignment: .leading){
        HStack(){
          Text("\(member.nickname)")
            .font(.custom("Pretendard-Bold", size: 13))
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 1))
          Text("\(member.role)")
            .font(.custom("Pretendard-Medium", size: 12))
            .padding(EdgeInsets(top: 1, leading: 8, bottom: 1, trailing: 8))
            .background(Color(hex: "E8F5E9"))
            .foregroundColor(Color(hex: "43A047"))
            .cornerRadius(4)
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0))
          Spacer()
          Text("\(member.descriptionTimeInterval)")
            .font(.custom("Pretendard-Medium", size: 13))
            .foregroundColor(Color(hex: "999999"))
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))

        Text("\((member.content == "" || member.content == nil ? "아직 인사를 건네기 전이에요." : member.content) ?? "")")
          .font(.custom("Pretendard-Regular", size: 14))
          .lineLimit(2)
          .foregroundColor(member.content == "" || member.content == nil ? Color.gray :  Color.black)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 16))
      }// VStack
      .onTapGesture{
        callback?()
      }

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

extension ChatRow{
  func onShowHistory(action: @escaping (() -> Void)) -> ChatRow {
    ChatRow(member, callback: action)
  }
}
//struct ChatRow_Previews: PreviewProvider {
//  static var previews: some View {
//    ChatRow(Member.getDummy())
//  }
//}
