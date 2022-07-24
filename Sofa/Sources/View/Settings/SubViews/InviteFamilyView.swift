//
//  InviteFamilyView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/24.
//

import SwiftUI

struct InviteFamilyView: View {
  @State var showContentView: Bool = false
  @ObservedObject var tabbarManager = TabBarManager.shared
  @State var inviteLinkText = "qlzpdl_dkdleldj_2909.com"
  @State var showToastMessage: Bool = false
  @State private var messageData: ToastMessage.MessageData = ToastMessage.MessageData(title: "복사 완료!", type: .Registration)
  var body: some View {
    ZStack{
      Color(hex: "FAF8F0").ignoresSafeArea(.all)
      
      VStack(spacing: 0){
        
        
        ZStack{
          Rectangle()
            .cornerRadius(8)
            .overlay( // cornerRadius값이 있는 border 주기 위해
              RoundedRectangle(cornerRadius: 8)
                  .stroke(Color(hex: "EDEADF"), lineWidth: 1)
            )
            .frame(height: 131)
            .foregroundColor(Color.white)
            .padding(.horizontal, 16)
            .padding(.top, 16)
          
          
          VStack(spacing: 0){
            ZStack{
              Rectangle()
                .frame(height: 47)
                .cornerRadius(6)
                .foregroundColor(Color(hex: "#FAF8F0"))
                .padding(.horizontal, 32)
                .padding(.top, 16)
              HStack{
                Text("\(inviteLinkText)")
                  .foregroundColor(Color.black.opacity(0.4))
                  .font(.custom("Pretendard-Medium", size: 18))
                  .padding(.horizontal, 44)
                  .padding(.top, 16)
                Spacer()
              }
              
            }
            
            Spacer()
              .frame(height: 4)
            
            Button {
              print("링크가 복사되었습니다.")
              UIPasteboard.general.string = self.inviteLinkText
              showToastMessage = true
            } label: {
              HStack{
                Image(systemName: "link")
                Text("링크 복사")
              }
              .frame(width: 326, height: 48, alignment: .center)
              .background(Color(hex: "FFB300"))
              .cornerRadius(6)
              .foregroundColor(Color.white)
            }
          }
          
          
        }
        
        Spacer()
        
        
      }
    }//ZStack
    .toastMessage(data: $messageData, isShow: $showToastMessage, topInset: 0)
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle("가족 초대")
    .onAppear{
      tabbarManager.showTabBar = false
    }
    .onDisappear{
      tabbarManager.showTabBar = true
    }
  }
  //  @State var inviteLink = "qlzpdl_dkdleldj_2909.com"
  //  @ObservedObject var tabbarManager = TabBarManager.shared
  //  var body: some View {
  //    VStack{
  //      VStack{
  //        TextField("", text: $inviteLink)
  //          .disabled(true)
  //          .frame(width: 326, height: 48, alignment: .center)
  //          .background(Color.pink)
  //        Button {
  //          print()
  //        } label: {
  //          HStack{
  //            Image(systemName: "link")
  //            Text("링크 복사")
  //          }
  //          .frame(width: 326, height: 48, alignment: .center)
  //          .background(Color(hex: "FFB300"))
  //          .foregroundColor(Color.white)
  //        }
  //
  //      }// VStack
  //      .padding(.horizontal, 16)
  //      .background(Color.white)
  //    }// VStack
  //    .navigationBarTitleDisplayMode(.inline)
  //    .navigationTitle("가족 초대")
  //    .onAppear{
  //      tabbarManager.showTabBar = false
  //    }
  //    .onDisappear{
  //      tabbarManager.showTabBar = true
  //    }
  //    .ignoresSafeArea()
  //    .background(Color(hex: "#FAF8F0"))
  //  }
}

struct InviteFamilyView_Previews: PreviewProvider {
  static var previews: some View {
    InviteFamilyView()
  }
}
