//
//  tmpView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/07.
//

import SwiftUI

struct tmpView: View {
  
  @Binding var selection: String
  
  var body: some View {
    
    let colors = [
      "#4CAF50",
      "#8BC34A",
      "#FFA000",
      "#4589FF",
      "#0072C3",
      "#A56EFF"
    ]
    
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 28)), count: 6)) {
      ForEach(colors, id: \.self) { color in
        Circle()
          .foregroundColor(Color(hex: color))
          .overlay(
            Circle()
              .stroke(.black.opacity(0.05), lineWidth: 1)
          )
          .padding(5)
          .overlay(
            Circle()
              .stroke(.black.opacity(0.05), lineWidth: 1)
          )
          .frame(width: 28, height: 28)
          .highlightColor(lineWidth: selection == color ? 4 : 0)
          .onTapGesture {
            selection = color
          }
      }
    }
  }
}

struct tmpView_Previews: PreviewProvider {
  static var previews: some View {
    tmpContent()
  }
}
