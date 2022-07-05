//
//  TaskColorPicker.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/05.
//

import SwiftUI

struct TaskColorPicker: View {
  
  @State private var showColorPicker = false
  @State private var isClicked = false
  @State private var currentColor: String = "4CAF50"
  
  @State private var isGreenClicked = false
  @State private var isLightGreenClicked = false
  @State private var isAmberClicked = false
  @State private var isBlueClicked = false
  @State private var isCyanClicked = false
  @State private var isPurpleClicked = false
  
  var body: some View {
    VStack(spacing: 0){
      HStack(spacing: 0){
        Circle()
          .foregroundColor(Color(hex: currentColor))
          .overlay(
            Circle()
              .stroke(.black.opacity(0.05), lineWidth: 1)
          )
          .padding(3)
          .overlay(
            Circle()
              .stroke(.black.opacity(0.05), lineWidth: 1)
          )
          .frame(width: 24, height: 24)
        
        Text("색상")
          .font(.custom("Pretendard-Medium", size: 16))
          .foregroundColor(Color(hex: "121619"))
          .padding(.leading, 10)
        
        Spacer()
        
        Button(action: {
          withAnimation {
            self.showColorPicker.toggle()
            self.isClicked.toggle()
          }
        }) {
          Image(systemName: self.isClicked ? "chevron.down" : "chevron.right" )
            .font(.system(size: 20))
            .frame(width: 24, height: 24)
            .foregroundColor(self.isClicked ? Color(hex: "#121619") : Color(.black).opacity(0.4) )
        }
      }
      
      if showColorPicker {
        HStack {
          Group{
          Circle()
            .foregroundColor(Color(hex: "4CAF50"))
            .overlay(
              Circle()
                .stroke(.black.opacity(0.05), lineWidth: 1)
            )
            .padding(5)
            .overlay(
              Circle()
                .stroke(.black.opacity(0.05), lineWidth: 1)
            )
            .padding(self.isGreenClicked ? 1 : 0)
            .overlay(
              Circle()
                .stroke(Color(hex: "#4CAF50").opacity(0.4), lineWidth: self.isGreenClicked ? 4 : 0)
            )
            .frame(width: self.isBlueClicked ? 28 : 28, height: self.isBlueClicked ? 28 : 28)
            .onTapGesture {
              self.currentColor = "4CAF50"
              self.isGreenClicked = true
              self.isAmberClicked = false
              self.isLightGreenClicked = false
              self.isBlueClicked = false
              self.isCyanClicked = false
              self.isPurpleClicked = false
            }
          Spacer()
          }
          
          Circle()
            .foregroundColor(Color(hex: "#8BC34A"))
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
            .onTapGesture {
              self.currentColor = "#8BC34A"
              self.isGreenClicked = false
              self.isAmberClicked = false
              self.isLightGreenClicked = true
              self.isBlueClicked = false
              self.isCyanClicked = false
              self.isPurpleClicked = false
            }
          
          Spacer()
          Circle()
            .foregroundColor(Color(hex: "#FFA000"))
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
            .onTapGesture {
              self.currentColor = "#FFA000"
              self.isGreenClicked = false
              self.isLightGreenClicked = false
              self.isAmberClicked = true
              self.isBlueClicked = false
              self.isCyanClicked = false
              self.isPurpleClicked = false
            }
          Spacer()
          
          Circle()
            .foregroundColor(Color(hex: "#4589FF"))
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
            .onTapGesture {
              self.currentColor = "#4589FF"
              self.isGreenClicked = false
              self.isLightGreenClicked = false
              self.isAmberClicked = false
              self.isBlueClicked = true
              self.isCyanClicked = false
              self.isPurpleClicked = false
            }
          Spacer()
          
          Circle()
            .foregroundColor(Color(hex: "#0072C3"))
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
            .onTapGesture {
              self.currentColor = "#0072C3"
              self.isGreenClicked = false
              self.isLightGreenClicked = false
              self.isAmberClicked = false
              self.isBlueClicked = false
              self.isCyanClicked = true
              self.isPurpleClicked = false
            }
          Spacer()
          
          Circle()
            .foregroundColor(Color(hex: "#A56EFF"))
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
            .onTapGesture {
              self.currentColor = "#A56EFF"
              self.isGreenClicked = false
              self.isLightGreenClicked = false
              self.isAmberClicked = false
              self.isBlueClicked = false
              self.isCyanClicked = false
              self.isPurpleClicked = true
            }
        }
        .padding(.top, 24)
        
        Rectangle()
          .foregroundColor(Color(hex: "#EDEADF"))
          .frame(height: 1)
          .padding(.top, 12)
          .padding(.bottom, 16)
      } else {
        Rectangle()
          .foregroundColor(Color.white)
          .frame(height: 28)
      }
    }
   
    .padding(.leading, 16)
    .padding(.trailing, 16)
  }
}

struct TaskColorPicker_Previews: PreviewProvider {
  static var previews: some View {
    AppendTaskModalView()
  }
}
