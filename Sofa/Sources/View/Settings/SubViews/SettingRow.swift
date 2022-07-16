//
//  SettingRow.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/16.
//

import SwiftUI

struct SettingRow: View {
  
  @Binding var isButtonClick: Bool
  var buttonName: String = ""
  var title: String = ""
  var isLast: Bool = false
  
  var body: some View {
    VStack(spacing: 0){
      HStack(spacing: 0){
        //이미지
        Image(systemName: buttonName)
          .foregroundColor(Color(hex:  "#4CAF50"))
          .frame(width: 24, height: 24, alignment: .center)
          .padding(.leading, 17)
        
        //글자
        Text(title)
          .font(.custom("Pretendard-Medium", size: 16))
          .foregroundColor(Color(hex: "#121619"))
          .padding(.leading, 10)
        
        
        Spacer()
        
        //버튼
        Button(action: {
          isButtonClick = true
        }, label: {
          Image(systemName: "chevron.right")
            .font(.system(size: 20, weight: .medium))
            .frame(width: 15, height: 20, alignment: .center)
            .foregroundColor(Color.black.opacity(0.4))
        })
        .padding(.trailing, 20.5)
        
      }
      .listRowInsets(EdgeInsets())
      .frame(height: 47)
      
      if !isLast {
      Divider()
        .frame(width: Screen.maxWidth-32, height: 1.0, alignment: .center)
      }
      
    }.frame(height: 48)
  }
}

struct SettingRow_Previews: PreviewProvider {
    static var previews: some View {
      SettingRow(isButtonClick: .constant(true), buttonName: "mic", title: "공지")
    }
}
