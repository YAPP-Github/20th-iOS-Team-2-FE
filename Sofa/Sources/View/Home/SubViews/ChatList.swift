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
      LazyVStack(spacing: 8) {
        ForEach(Array(zip(memberViewModel.members.indices, memberViewModel.members)), id: \.1){ index, member in
          Button {
            print("Animation")
            withAnimation(Animation.easeInOut(duration: 0.5)) {
              let selectedMember = member
              memberViewModel.members = memberViewModel.members.filter { $0.userId != member.userId }
              memberViewModel.members.insert(selectedMember, at: 0)
            }
            
          } label: {
            ChatRow(member)
          }
          .buttonStyle(.automatic)
        }
        
      }
      .background(Color(hex: "F9F7EF"))
      .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
    }
  }
  
  func move(from source: IndexSet, to destination: Int) {
    if let first = source.first {
      memberViewModel.members.swapAt(first, destination)
    }
  }
  
  func moveRow(from source: IndexSet, to destination: Int) {
    memberViewModel.members.move(fromOffsets: source, toOffset: destination)
  }
}


struct ChatList_Previews: PreviewProvider {
  static var previews: some View {
    ChatList()
  }
}
