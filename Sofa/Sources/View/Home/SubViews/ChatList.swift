//
//  ChatList.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import SwiftUI

struct ChatList: View {
  
  
  @Binding var historyUserId: Int
  @Binding var showModal: Bool
  @ObservedObject var ChatShared = Chat.shared
  
  var function: (() -> Void)?
  
  var body: some View {
    
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 8) {
        if ChatShared.members.count > 0{
          
          ForEach(Array(zip(ChatShared.members.indices, ChatShared.members)), id: \.1){ index, member in
            ChatRow(member, callback: function)
              .onShowHistory {
                self.showModal = true
                self.historyUserId = ChatShared.members[index].userId
                print("\(ChatShared.members[index].userId)")
              }
          }
          .onChange(of: ChatShared.members) { newValue in
            if ChatShared.getData {
              print(ChatShared.members)
              DispatchQueue.main.async {
                withAnimation(Animation.easeOut(duration: 0.3)) {
                  print(ChatShared.indexs)
                  self.ChatShared.members.bringToFront(item: self.ChatShared.members[ChatShared.moveIndex])
                  for i in (0...self.ChatShared.members.count-1){
                    self.ChatShared.indexs[self.ChatShared.members[i].userId] = i
                    print(self.ChatShared.indexs)
                  }
                }
              }
            }
            
            ChatShared.getData = false

          }
        }
        
      }//LazyVStack
      .background(Color(hex: "F9F7EF"))
      .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }//ScrollView
    
    Button {
      withAnimation(Animation.easeOut(duration: 0.3)) {
        moveRow(from: IndexSet(integer: ChatShared.members.count-1), to: 0)
        //        memberViewModel.members.reverse()
      }
    } label: {
      Text(".")
        .foregroundColor(Color(hex: "F9F7EF"))
    }
    
  }
  
  func moveRow(from source: IndexSet, to destination: Int) {
    ChatShared.members.move(fromOffsets: source, toOffset: destination)
  }
}

//
//struct ChatList_Previews: PreviewProvider {
//  static var previews: some View {
//    ChatList()
//  }
//}
