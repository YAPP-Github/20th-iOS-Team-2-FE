//
//  EventList.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import SwiftUI

struct EventList: View {
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 16) {
        ForEach(0...4, id: \.self) { index in
          if index == 0{
            EventRow(Event.getDummy())
              .frame(width: 320)
              .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
          }
          else if index == 4{
            EventRow(Event.getDummy())
              .frame(width: 320)
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
          }
          else{
            EventRow(Event.getDummy())
              .frame(width: 320)
          }
        }
      }
    }
    .background(Color(hex: "#EDEADF"))
  }
}

struct EventList_Previews: PreviewProvider {
  static var previews: some View {
    EventList()
  }
}
