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
    VStack {
      
      ZStack{
        Capsule()
          .frame(width: 48, height: 4)
          .foregroundColor(Color.black)
          .opacity(0.24)
      }
      .frame(height: 40)
      .frame(maxWidth: .infinity)
      .background(Color.white.opacity(0.00001))
      .gesture(dragGesture)
      
      ZStack{
        VStack{
          Text("Hello")
        }
        .padding(.horizontal, 30)
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
