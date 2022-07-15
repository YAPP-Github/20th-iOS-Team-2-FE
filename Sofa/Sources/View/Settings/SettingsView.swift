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
          
          //첫번재 단락
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
