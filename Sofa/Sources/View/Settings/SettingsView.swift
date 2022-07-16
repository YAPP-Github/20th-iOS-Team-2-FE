//
//  SettingsView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    NavigationView {
      ZStack{
        Color(hex: "FAF8F0").ignoresSafeArea()
        VStack(spacing: 0){
          Rectangle()
            .frame(height: 1.0, alignment: .bottom)
            .foregroundColor(Color(hex: "EDEADF"))
          
          //첫번째 단락
          HStack{
            VStack{
              //글씨1
              //글씨2
            }
            //버튼
          }
          HStack{
            //사진
            VStack{
              //글씨1
              //글씨2
            }
            //버튼
          }
          
          //두번째 단락
          List {
            SettingRow(isButtonClick: .constant(true), buttonName: "person.fill.badge.plus", title: "가족 초대")
            SettingRow(isButtonClick: .constant(true), buttonName: "bell.fill", title: "알림")
            SettingRow(isButtonClick: .constant(true), buttonName: "shield.lefthalf.filled", title: "계정 및 보안")
            SettingRow(isButtonClick: .constant(true), buttonName: "gearshape.fill", title: "설정")
            SettingRow(isButtonClick: .constant(true), buttonName: "mic", title: "공지")
            SettingRow(isButtonClick: .constant(true), buttonName: "star.fill", title: "소파리뷰")
          }
          .listRowInsets(EdgeInsets())
          .listStyle(InsetListStyle())
          .frame(width: Screen.maxWidth, height: 300, alignment: .center)
          
          Spacer()
          
        }///VStack
        .navigationBarWithIconButtonStyle(isButtonClick: .constant(false), buttonColor: Color.clear, "설정", "")
      }///ZStack
    }///NavigationView
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
