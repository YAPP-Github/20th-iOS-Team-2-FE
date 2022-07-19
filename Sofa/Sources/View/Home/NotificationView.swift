//
//  NotificationView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/08.
//

import SwiftUI

struct NotificationView: View {
  @Environment(\.presentationMode) var presentationMode
  @State var gotoAlarmSetting = false
  @ObservedObject var notificationViewModel = NotificationViewModel()
  @Binding var selectionType: Tab
  
  
  var periodArr = ["오늘", "이번 주", "이번 달"]
  var taskDict = ["CALENDAR" : "일정", "ALBUM" : "사진"]
  
  // notification 내 createDate 기준 날짜 필터링
  let today = NotificationViewModel().notification.filter { notification in
    notification.getIntervalTime >= 0 && notification.getIntervalTime < 86400
  }
  let thisweek = NotificationViewModel().notification.filter { notification in
    notification.getIntervalTime >= 86400 && notification.getIntervalTime < 604800
  }
  let thismonth = NotificationViewModel().notification.filter { notification in
    notification.getIntervalTime >= 604800 && notification.getIntervalTime < 2592000
  }
  
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        ForEach(periodArr.indices, id: \.self) { i in
          if getPeriodType(periodArr[i]).count > 0{ // 해당 기간에 없으면 표시 X
            Rectangle()
              .foregroundColor(Color(hex: "FAF8F0"))
              .frame(height: 8)
            HStack {
              Spacer()
                .frame(width: 16)
              Text("\(periodArr[i])")
                .font(.custom("Pretendard-Bold", size: 13))
                .foregroundColor(Color(hex: "999899"))
              Spacer()
            }
            .frame(height: 52)
            .background(Color.white)
          }
          ForEach(Array(zip(getPeriodType(periodArr[i]).indices, getPeriodType(periodArr[i]))), id: \.1) { idx, notification in
//            NavigationLink {
//              AlbumImageDetailView(image: UIImage(imageLiteralResourceName: "photo01"), index: 0)
//            } label: {
//              alarmRow(notification)
//            }
            NotificationRow(notification)
              .onTapGesture {
                if notification.type == "CALENDAR"{
                  self.selectionType = .calendar
                  print("CALENDAR")
                }else if notification.type == "ALBUM"{
                  self.selectionType = .album
                  print("ALBUM")
                }
                
                self.presentationMode.wrappedValue.dismiss()
                
              }

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
        Rectangle()
          .foregroundColor(Color(hex: "FAF8F0"))
          .frame(height: UIDevice().hasNotch ? 40 : 0)
      }
    }// ScrollView
    .background(Color(hex: "FAF8F0"))
    .padding(.top, 1) // ignoreSafeArea 적용 X
    .padding(.bottom, 5)
    .edgesIgnoringSafeArea([.bottom])
    .onDisappear{
      UITabBar.showTabBar(animated: false)
    }

  }
  
  func getPeriodType(_ periodType: String) -> Array<Notification>{
     switch periodType {
     case "오늘":
       return today
     case "이번 주":
       return thisweek
     case "이번 달":
        return thismonth
     default:
       return today
     }
  }
  
  //MARK: - NotificationRow
  func NotificationRow(_ notification: Notification) ->some View{
    HStack(alignment: .top){
      Image("lionprofile")
        .resizable()
        .frame(width: 51, height: 52.5)
        .padding(EdgeInsets(top: 0, leading: 14.5, bottom: 0, trailing: 14.5))
      Spacer()
      CustomBoldLabelView(text1: " 님이 새로운 ", text2: "을 등록했습니다.", user: "\(notification.user)", task: "\(taskDict[notification.type] ?? "없음")")
        .frame(height: 40)
      
      Spacer()
        .frame(width: 8)
      Text("\(notification.descriptionIntervalTime)")
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
//
//struct NotificationView_Previews: PreviewProvider {
//  static var previews: some View {
//    NotificationView()
//  }
//}
