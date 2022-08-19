//
//  TaskColorPicker.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/05.
//

import SwiftUI
//
//struct TaskColorPicker: View {
//  
//  @State private var isButtonClicked = false
//  @State private var showColorPicker = false
//  @State var selectedColor: String
//  
//  var colorPicker: some View {
//    VStack(spacing: 0){
//      HStack(spacing: 0){
//        Circle()
//          .foregroundColor(Color(hex: selectedColor))
//          .overlay(
//            Circle()
//              .stroke(.black.opacity(0.05), lineWidth: 1)
//          )
//          .padding(3)
//          .overlay(
//            Circle()
//              .stroke(.black.opacity(0.05), lineWidth: 1)
//          )
//          .frame(width: 24, height: 24)
//        
//        Text("색상")
//          .font(.custom("Pretendard-Medium", size: 16))
//          .foregroundColor(Color(hex: "121619"))
//          .padding(.leading, 10)
//        
//        Spacer()
//        
//        Button(action: {
//          withAnimation {
//            self.showColorPicker.toggle()
//            self.isButtonClicked.toggle()
//          }
//        }) {
//          Image(systemName: self.isButtonClicked ? "chevron.down" : "chevron.right" )
//            .font(.system(size: 20))
//            .frame(width: 24, height: 24)
//            .foregroundColor(self.isButtonClicked ? Color(hex: "#121619") : Color(.black).opacity(0.4) )
//        }
//      }
//      
//      if showColorPicker {
//        ColorCircles(selectedColor: $selectedColor)
//          .padding(.top, 24)
//        
//        Rectangle()
//          .foregroundColor(Color(hex: "#EDEADF"))
//          .frame(height: 1)
//          .padding(.top, 12)
//          .padding(.bottom, 16)
//      } else {
//        Rectangle()
//          .foregroundColor(Color.white)
//          .frame(height: 28)
//      }
//    }
//    .padding(.leading, 16)
//    .padding(.trailing, 16)
//  }
//}
//
//struct TaskColorPicker_Previews: PreviewProvider {
//  static var previews: some View {
//    TaskColorPicker(selectedColor: "#43A047")
//  }
//}
