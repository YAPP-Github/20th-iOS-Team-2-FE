//
//  ModalView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/05.
//

import SwiftUI

struct ModalView: View {
  
  @Binding var isShowing: Bool
  @State private var isDragging = false
  
  @State private var curHeight: CGFloat = 400
  let minHeight: CGFloat = Screen.maxHeight / 2
  let maxHeight: CGFloat = Screen.maxHeight * 0.9
  
  
  
  var body: some View {
    ZStack(alignment: .bottom){
      if isShowing{
        Color.black
          .opacity(0.7)
          .onTapGesture {
            isShowing = false
          }
        mainView
          .transition(.move(edge: .bottom))
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .ignoresSafeArea()
    .animation(.easeInOut)
  }
  
  var mainView: some View{
    VStack(alignment: .center) {
      
      ZStack(alignment: .center){
        Capsule()
          .frame(width: 48, height: 4)
          .foregroundColor(Color.black)
          .opacity(0.24)
      }
      .frame(height: 40)
      .frame(maxWidth: .infinity)
      .background(Color.white.opacity(0.00001))
      .gesture(dragGesture)
      
      ZStack(alignment: .center){
        VStack{
          HStack(alignment: .top){
            Image("lionprofile")
              .frame(width: 51, height: 52.5)
              .padding(EdgeInsets(top: 10.5, leading: 10.5, bottom: 27, trailing: 14.5))
            VStack(alignment: .leading){
              HStack(){
                Text("별명")
                  .font(.custom("Pretendard-Bold", size: 13))
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 1))
                Text("관계")
                  .font(.custom("Pretendard-Medium", size: 12))
                  .padding(EdgeInsets(top: 1, leading: 8, bottom: 1, trailing: 8))
                  .background(Color(hex: "E8F5E9"))
                  .foregroundColor(Color(hex: "43A047"))
                  .cornerRadius(4)
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 4, trailing: 0))
                Spacer()
                Text("2022-12-25")
                  .font(.custom("Pretendard-Medium", size: 13))
                  .foregroundColor(Color(hex: "999999"))
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
              }
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }// VStack
          }// HStack
          Divider()
            .overlay(Color(hex: "EDEADF"))
            .offset(x:0, y: -30)
          Spacer()
          HStack(alignment: .center){
            Button {
              print("left")
            } label: {
              Text("<")
                .font(.system(size: 20))
            }
            Spacer()
            Text("1 / 24")
              .font(.custom("Pretendard-Medium", size: 20))
            Spacer()
            Button {
              print("left")
            } label: {
              Text(">")
            }
          }
          .padding(.vertical, 16)
          .padding(.horizontal, 24)
        }//VStack
        
        
        
        
      }
      .frame(maxHeight: .infinity)
    }
    .frame(height: curHeight)
    .frame(maxWidth: .infinity)
    .background(
      ZStack{
        RoundedRectangle(cornerRadius: 20)
        Rectangle()
          .frame(height: curHeight / 2)
      }
        .foregroundColor(.white)
    )
    .animation(isDragging ? nil : .easeInOut(duration: 0.45))
  }
  
  @State private var prevDragTranslation = CGSize.zero
  
  var dragGesture: some Gesture{
    DragGesture(minimumDistance: 0, coordinateSpace: .global)
      .onChanged { val in
        if !isDragging {
          isDragging = true
        }
        
        let dragAmount = val.translation.height - prevDragTranslation.height
        
        if curHeight > maxHeight || curHeight < minHeight{
          curHeight -= dragAmount / 6
        }
        else{
          curHeight -= dragAmount
        }
        
        prevDragTranslation = val.translation
      }
      .onEnded { val in
        prevDragTranslation = .zero
        isDragging = false
        if curHeight > minHeight + 35 {
          curHeight = maxHeight
        }
        else if curHeight < minHeight - 35{
          isShowing = false
          curHeight = minHeight
        }
        else{
          curHeight = minHeight
        }
      }
  }
}

struct ModalView_Previews: PreviewProvider {
  static var previews: some View {
    ModalView(isShowing: .constant(true))
  }
}
