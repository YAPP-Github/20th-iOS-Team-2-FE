//
//  AccountAndSecurityView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/25.
//

import SwiftUI

struct AccountAndSecurityView: View {
  
  let titles = ["개인정보 이용 약관", "서비스 이용 약관", "로그아웃", "계정 삭제"]
  @ObservedObject var tabbarManager = TabBarManager.shared
  var body: some View {
    VStack(spacing: 0){
      VStack(spacing: 0){
        ForEach(titles.indices) { idx in
          NavigationLink {
            Text("hihhihihih")
          } label: {
            settingSubRowView(titles[idx], idx)
          }
        }

        Rectangle()
          .foregroundColor(Color(hex: "EDEADF"))
          .frame(height: 1)
      }// VStack
      .background(Color.white)
      Spacer()
    }// VStack
    .background(Color(hex: "#FAF8F0"))
    .onAppear{
      tabbarManager.showTabBar = false
    }
    .navigationTitle("계정 및 보안")
    .edgesIgnoringSafeArea([.bottom])
  }
  
  func settingSubRowView(_ title: String, _ idx: Int) -> some View {
    VStack(spacing: 0){
      VStack(alignment: .center, spacing: 0){
        HStack(alignment: .center, spacing: 0){

          //글자
          Text(title)
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color(hex: "#121619"))
            .padding(.leading, 16)
          
          
          Spacer()
          
          //버튼
          Image(systemName: "chevron.right")
            .font(.system(size: 20, weight: .medium))
            .frame(width: 15, height: 20, alignment: .center)
            .foregroundColor(Color.black.opacity(0.4))
          .padding(.trailing, 20.5)
          
        }// HStack
        .frame(height: 48)
      }// VStack
      .background(Color.white)
      .frame(height: 48)
      if idx != 3{
        Rectangle()
          .foregroundColor(Color.black)
          .opacity(0.05)
          .frame(height: 0.5)
          .padding(.horizontal, 16)
      }
    }//VStack
  }
}

struct AccountAndSecurityView_Previews: PreviewProvider {
  static var previews: some View {
    AccountAndSecurityView()
  }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
