//
//  ChatList.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import SwiftUI

struct ChatList: View {
  
  @ObservedObject var memberViewModel = MemberViewModel()
  @Binding var showModal: Bool
  @StateObject var socket = StarscreamWebsocket()
  @ObservedObject var ChatShared = Chat.shared

  var function: (() -> Void)?
  
  var body: some View {

    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack(spacing: 8) {
//        ForEach(Array(zip(memberViewModel.members.indices, memberViewModel.members)), id: \.1){ index, member in
//          ChatRow(member, callback: function)
//            .onShowHistory {
//              self.showModal = true
//              print("\(index)")
//            }
//        }
        if ChatShared.members.count > 0{

          ForEach(Array(zip(ChatShared.members.indices, ChatShared.members)), id: \.1){ index, member in
            ChatRow(member, callback: function)
              .onShowHistory {
                self.showModal = true
                print("\(index)")
              }
          }
        }
        
      }
      .background(Color(hex: "F9F7EF"))
      .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
    
    Button {
      withAnimation(Animation.easeOut(duration: 0.3)) {
        moveRow(from: IndexSet(integer: memberViewModel.members.count-1), to: 0)
//        memberViewModel.members.reverse()
      }
    } label: {
      Text(".")
        .foregroundColor(Color(hex: "F9F7EF"))
    }

  }
  
  func moveRow(from source: IndexSet, to destination: Int) {
    memberViewModel.members.move(fromOffsets: source, toOffset: destination)
  }
}

//
//struct ChatList_Previews: PreviewProvider {
//  static var previews: some View {
//    ChatList()
//  }
//}
