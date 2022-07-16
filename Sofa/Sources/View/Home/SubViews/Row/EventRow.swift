//
//  EventRow.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import SwiftUI

struct EventRow: View {
  
  var callback: (() -> Void)?
  var event: Event
  
  init(_ event: Event, callback: (() -> Void)?){
    self.event = event
    self.callback = callback
  }
  
  
  var body: some View {
    HStack{
      if event.descriptionTitle.contains("생일"){ // 생일 이미지
        Image("birthday")
          .resizable()
          .frame(width: 48, height: 48)
      }
      else{ // 그 외 일정 이미지
        Image("greencolorIcon")
          .resizable()
          .frame(width: 48, height: 48)
      }
      HStack{
        VStack(alignment: .leading, spacing: 3){
          Text("\(event.descriptionTitle)")
            .font(.custom("Pretendard-Bold", size: 16))
          Text("이벤트 \(event.descriptionIntervalDate)")
            .font(.custom("Pretendard-Regular", size: 14))
        }
        Spacer()
        VStack(alignment: .trailing, spacing: 5.5){
          Button(action: {
//            print("DELETE ROW")
            callback?()
          }, label: {
            Image("x.circle.fill")
          })
          .frame(width: 20, height: 20)
          Text("\(event.descriptionDate)")
            .font(.custom("Pretendard-Regular", size: 13))
            .foregroundColor(Color(hex: "#919090"))
            .padding(.horizontal, 8)
            .background(Color(hex: "#F2F1F1"))
            .cornerRadius(80)
        }
      }// HStack
    }// HStack
    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
    .background(Color.white)
    .cornerRadius(8)
    .frame(height: 64)
    .overlay( // cornerRadius값이 있는 border 주기 위해
      RoundedRectangle(cornerRadius: 8)
          .stroke(Color(hex: "EDEADF"), lineWidth: 1)
    )
  }
}

extension EventRow{
  func onDeleteRow(action: @escaping (() -> Void)) -> EventRow {
    EventRow(event, callback: action)
  }
}
//struct EventRow_Previews: PreviewProvider {
//  static var previews: some View {
//    EventRow(Event.getDummy())
//  }
//}
