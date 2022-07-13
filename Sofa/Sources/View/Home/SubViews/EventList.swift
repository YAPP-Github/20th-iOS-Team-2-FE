//
//  EventList.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import SwiftUI
import SwiftUIPager

struct EventList: View {
  
  @ObservedObject var eventViewModel = EventViewModel()
  @StateObject var page: Page = .first()
  @State var alignment: SofaPositionAlignment = .start
  @Binding var selectionType: Tab
  var function: (() -> Void)?
  
  var body: some View {
    Pager(page: page,
          data: eventViewModel.events.indices,
          id: \.self,
          content: { index in
      // create a page based on the data passed
      if eventViewModel.events.count > 0 {
        EventRow(eventViewModel.events[index], callback: function)
          .onDeleteRow {
            print("\(index)")
            if eventViewModel.events.count > 0{
              eventViewModel.events.remove(at: index)
            }
          }
          .onTapGesture {
            self.selectionType = .calendar
          }
      }
    })
    .onPageChanged({ (newIndex) in
      if newIndex == 0 {
        withAnimation {
          self.alignment = .start
        }
      }
      else if newIndex == eventViewModel.events.count {
        withAnimation {
          self.alignment = .end
        }
      }
      else{
        withAnimation {
          self.alignment = .justified
        }
      }
      
    })
    .alignment(PositionAlignment(alignment: self.alignment))
    .singlePagination(ratio: 0.66, sensitivity: .high)
    .itemSpacing(16)
    .preferredItemSize(CGSize(width: eventViewModel.events.count > 1 ? Screen.maxWidth - 72 : Screen.maxWidth - 32, height: 100))
  }
  
}

enum SofaPositionAlignment: String, CaseIterable{
  case start
  case justified
  case end
}

extension PositionAlignment {
  init(alignment: SofaPositionAlignment) {
    switch alignment {
    case .start:
      self = .start(16)
    case .end:
      self = .end(16)
    case .justified:
      self = .justified(16)
    }
  }
}
//
//struct EventList_Previews: PreviewProvider {
//  static var previews: some View {
//    EventList()
//  }
//}
