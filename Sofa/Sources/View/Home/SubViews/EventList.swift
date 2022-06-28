//
//  EventList.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import SwiftUI

struct EventList: View {
  
  @ObservedObject var eventViewModel = EventViewModel()
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 16) {
        
        ForEach(Array(zip(eventViewModel.events.indices, eventViewModel.events)), id: \.0){ index, event in
          if index == 0{ // 첫번째 row
            EventRow(event)
              .frame(width: 320)
              .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
          }
          else if index == eventViewModel.events.count - 1{ // 마지막 row
            EventRow(event)
              .frame(width: 320)
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
          }
          else{
            EventRow(event)
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
