//
//  ChatList.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import SwiftUI

struct ChatList: View {
  
  @ObservedObject var memberViewModel = MemberViewModel()
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 16) {
        
        ForEach(Array(zip(memberViewModel.members.indices, memberViewModel.members)), id: \.0){ index, member in
          if index == 0{ // 첫번째 row
            ChatRow(member)
              .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
          }
          else if index == memberViewModel.members.count - 1{ // 마지막 row
            ChatRow(member)
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
          }
          else{
            ChatRow(member)
          }
        }

      }
      .background(Color(hex: "F9F7EF"))
    }
  }
}


struct ChatList_Previews: PreviewProvider {
  static var previews: some View {
    ChatList()
  }
}
