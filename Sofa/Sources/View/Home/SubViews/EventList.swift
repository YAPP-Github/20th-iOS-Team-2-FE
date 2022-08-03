//
//  EventList.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import SwiftUI
import SwiftUIPager

struct EventList: View {
  
  @StateObject var homeinfoVM = HomeInfoViewModel()
  @StateObject var page: Page = .first()
  @State var alignment: SofaPositionAlignment = .start
  @State var viewAppear: Bool = false
  @Binding var selectionType: Tab
  @Binding var dateToShow: String
  var function: (() -> Void)?
  
  var body: some View {
    Pager(page: page,
          data: homeinfoVM.events.indices,
          id: \.self,
          content: { index in
      // create a page based on the data passed
      if homeinfoVM.events.count > 0 {
        EventRow(homeinfoVM.events[index], callback: function)
          .onDeleteRow {
            print("\(index)")
            if homeinfoVM.events.count > 0{
              homeinfoVM.events.remove(at: index)
            }
          }
          .onTapGesture {
            self.selectionType = .calendar
            self.dateToShow = homeinfoVM.events[index].descriptionDate
          }
      }
    })
    .onPageChanged({ (newIndex) in
      if newIndex == 0 {
        withAnimation {
          self.alignment = .start
        }
      }
      else if newIndex == homeinfoVM.events.count {
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
    .singlePagination(ratio: 0.8, sensitivity: .high)
    .itemSpacing(16)
    .preferredItemSize(CGSize(width: homeinfoVM.events.count > 1 ? Screen.maxWidth - 72 : Screen.maxWidth - 32, height: 100))
    .animation(viewAppear ? .default : .none)
    .onAppear{
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.viewAppear = true
      }
    }
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
