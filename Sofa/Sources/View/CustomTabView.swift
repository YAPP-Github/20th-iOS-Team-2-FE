//
//  CustomTabView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/19.
//

import SwiftUI

struct CustomTabView: View {
  
  @Binding var selected: Int
  var body: some View {
    HStack(alignment: .center, spacing: 8){
      ForEach(0..<4) { i in
        Spacer()
          .frame(width: Screen.maxWidth * 0.05)
        Button {
          
        } label: {
          switch i{
          case 0:
            VStack{
              Image(systemName: selected == 0 ? "hand.wave.fill" : "hand.wave")
                .font(.system(size: 24 ))
                .padding(.vertical, 10)
                .foregroundColor(selected == 0 ? Color(hex: "43A047") : Color.gray)
              Spacer()
            }
            
          case 1:
            VStack{
              Image(systemName: "calendar")
                .font(.system(size: 24))
                .padding(.vertical, 10)
                .foregroundColor(selected == 1 ? Color(hex: "43A047") : Color.gray)
              Spacer()
            }
          case 2:
            VStack{
              Image(systemName: selected == 2 ? "book.closed.fill" : "book.closed")
                .font(.system(size: 24))
                .padding(.vertical, 8.5)
                .foregroundColor(selected == 2 ? Color(hex: "43A047") : Color.gray)
              Spacer()
            }
          case 3:
            VStack{
              Image(systemName: "ellipsis")
                .font(.system(size: 24))
                .padding(.vertical, 17)
                .foregroundColor(selected == 3 ? Color(hex: "43A047") : Color.gray)
              Spacer()
            }
          default:
            Image(systemName: "ellipsis")
              .font(.system(size: 24))
              .foregroundColor(Color.gray)
          }
        }
        
        Spacer()
          .frame(width: Screen.maxWidth * 0.05)
      } //HStack
      .frame(height: UIDevice().hasNotch ? Screen.maxHeight * 0.11 : Screen.maxHeight * 0.11 - 5)
    }
    .frame(width: Screen.maxWidth)
    .background(Color.white)
  }
}

//struct CustomTabView_Previews: PreviewProvider {
//  static var previews: some View {
//    CustomTabView(selected: <#Binding<Int>#>)
//  }
//}
