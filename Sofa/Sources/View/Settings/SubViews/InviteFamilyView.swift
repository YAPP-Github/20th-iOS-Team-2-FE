//
//  InviteFamilyView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/24.
//

import SwiftUI

struct InviteFamilyView: View {
  @State var inviteLink = ""
  @ObservedObject var tabbarManager = TabBarManager.shared
  var body: some View {
    VStack{
      VStack{
        TextField("", text: $inviteLink)
          .disabled(true)
          .background(Color.pink)
        Button {
          print()
        } label: {
          HStack{
            Image(systemName: "link")
            Text("링크 복사")
          }
          .background(Color(hex: "FFB300"))
        }

      }
      .padding(.horizontal, 16)
      .padding(.vertical, 16)
      .background(Color.white)
      Spacer()
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("가족 초대")
    .edgesIgnoringSafeArea([.bottom])
    .background(Color(hex: "#FAF8F0"))
    .onAppear{
      tabbarManager.showTabBar = false
    }
    .onDisappear{
      tabbarManager.showTabBar = true
    }
    .ignoresSafeArea()
  }
}

struct InviteFamilyView_Previews: PreviewProvider {
  static var previews: some View {
    InviteFamilyView()
  }
}
