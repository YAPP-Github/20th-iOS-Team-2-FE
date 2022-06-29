//
//  ChatList.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import SwiftUI

struct ChatList: View {
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 16) {
        ForEach(0...3, id: \.self){ idx in
          if idx == 0{ // 첫번째 row
            ChatRow()
              .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            
          }
          else if idx == 3{ // 마지막 row
            ChatRow()
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
          }
          else{
            ChatRow()
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
