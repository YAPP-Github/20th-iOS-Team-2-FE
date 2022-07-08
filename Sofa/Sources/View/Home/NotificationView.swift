//
//  NotificationView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/08.
//

import SwiftUI

struct NotificationView: View {
  @State var gotoAlarmSetting = false
  var periodArr = ["오늘", "이번 주", "이번 달"]
  
  init() {
    UINavigationBar.appearance().backgroundColor = .white
  }
  
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
            alarmRow(notification)
          }
          .toolbar {
            Button {
              print("goto알림")
            } label: {
              Text("설정")
                .foregroundColor(Color(hex: "43A047"))
            }
          }
          .environment(\.locale, .init(identifier: "ko_KR"))
          .navigationBarTitleDisplayMode(.inline)
          .navigationTitle("알림")

        }
      }
    }// ScrollView
    .offset(x:0, y: 1)
  }
  //MARK: - alarmRow
    func alarmRow(_ notification: Int) ->some View{
    HStack(alignment: .top){
      Image("lionprofile")
        .resizable()
        .frame(width: 51, height: 52.5)
        .padding(EdgeInsets(top: 0, leading: 14.5, bottom: 0, trailing: 14.5))
      Spacer()
//                .frame(width: 22.5)
      LabelView(text: "우리집 보스 님이 새로운 일정을 등록했습니다.")
        .font(.custom("Pretendard-Bold", size: 14))
        .foregroundColor(Color(hex: "121619"))
        .frame(height: 40)
      
      Spacer()
        .frame(width: 8)
      Text("방금 전")
        .font(.custom("Pretendard-Medium", size: 13))
        .foregroundColor(Color(hex: "A6A6A6"))
        .frame(width: 60)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 5))
    }
    .frame(width: Screen.maxWidth)
    .frame(height: 64)
    .background(Color.white)
  }
}

struct NotificationView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationView()
  }
}
