//
//  NotificationView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/08.
//

import SwiftUI

struct NotificationView: View {
  
  var periodArr = ["오늘", "이번 주", "이번 달"]
  
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 1) {
        ForEach(periodArr, id: \.self) { period in
          Rectangle()
            .foregroundColor(Color(hex: "FAF8F0"))
          HStack() {
            Text("\(period)")
              .font(.custom("Pretendard-Bold", size: 13))
              .foregroundColor(Color(hex: "999899"))
            Spacer()
          }
          .padding(EdgeInsets(top: 20, leading: 16, bottom: 12, trailing: 300))
          .background(Color.white)
          ForEach(0..<3) { notification in
            Text("hello")
          }
        }
      }
    }
  }
  
  var alarmRow: some View{
    HStack(alignment: .top){
      Image("lionprofile")
        .resizable()
        .frame(width: 51, height: 52.5)
        .padding(EdgeInsets(top: 10.5, leading: 14.5, bottom: 0, trailing: 8))
      Text("우리집 보스 님이 새로운 일정을 등록했습니다.")
    }
  }
}

struct NotificationView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationView()
  }
}
