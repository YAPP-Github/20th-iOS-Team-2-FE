//
//  EventRow.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import SwiftUI

struct EventRow: View {
  var event: Event
  
  init(_ event: Event){
    self.event = event
  }
  
  
  var body: some View {
    HStack{
      Image("birthday")
        .resizable()
        .frame(width: 48, height: 48)
      HStack{
        VStack(alignment: .leading, spacing: 3){
          Text("\(event.descriptionTitle)")
            .font(.custom("Pretendard-Bold", size: 16))
          Text("\(event.descriptionDate)")
            .font(.custom("Pretendard-Regular", size: 14))
        }
        Spacer()
        VStack(alignment: .trailing, spacing: 5.5){
          Button(action: {
            
          }, label: {
            Image("x.circle.fill")
          })
          .frame(width: 20, height: 20)
          Text("2022-12-25")
            .font(.custom("Pretendard-Regular", size: 13))
        }
      }// HStack
    }// HStack
    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
    .background(Color.white)
    .cornerRadius(8)
    .onTapGesture {
      print("Go To Calendar Tab")
    }
  }
}

struct EventRow_Previews: PreviewProvider {
  static var previews: some View {
    EventRow(Event.getDummy())
  }
}
