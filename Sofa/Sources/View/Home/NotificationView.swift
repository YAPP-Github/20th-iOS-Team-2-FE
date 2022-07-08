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
            HStack(alignment: .top){
              Image("lionprofile")
                .resizable()
                .frame(width: 51, height: 52.5)
                .padding(.horizontal, 10.5)
              Text("우리집 보스 님이 새로운 일정을 등록했습니다.")
                .multilineTextAlignment(.leading)
                .font(.custom("Pretendard-Regular", size: 14))
                .foregroundColor(Color(hex: "121619"))
                .frame(width: 200)
                .padding(.horizontal, 4)
              Text("방금 전")
                .font(.custom("Pretendard-Medium", size: 13))
                .foregroundColor(Color(hex: "A6A6A6"))
                .padding(.horizontal, 8)
            }
            .frame(height: 64)
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
          //          .navigationBarItem(title: Text(""), titleDisplayMode: ., hidesBackButton: true)
          //          .navigationBarWithTextButtonStyle(isNextClick: $gotoAlarmSetting, isDisalbeNextButton: .constant(false), "알림", nextText: "설정", Color.init(hex: "#43A047"))
          //          .navigationBarBackButtonHidden(true)
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

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: nil, action: nil)
    }
}
