//
//  EventRow.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import SwiftUI

struct EventRow: View {
  var event: Event
  
  var body: some View {
    HStack() {
      Text("EventRow")
    }
  }
}

struct EventRow_Previews: PreviewProvider {
  static var previews: some View {

    EventRow(event: <#Event#>)
  }
}
