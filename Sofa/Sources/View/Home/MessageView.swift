//
//  MessageView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/11.
//

import SwiftUI

struct MessageView: View {
  
  @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
  
  let placeholder = "가족에게 인사를 남겨보세요."
  @Binding var isShowing: Bool
  @State private var isDragging = false
  @State private var text: String?
  @State private var textLength: Int = 0
  @State private var textEditorHeight: CGFloat = 52
  @State private var increasedHeightValue: CGFloat = 0
  @State var startPos : CGPoint = .zero
  
  @State private var curHeight: CGFloat = 120
  
  @State var minHeight: CGFloat = 120
  //  let maxHeight: CGFloat = (Screen.maxHeight - yoffset) * 0.9
  
  init(_ isShowing: Binding<Bool>){
    _isShowing = isShowing
  }
  
  var body: some View {
    ZStack(alignment: .bottom){
      if isShowing{
        VStack {
          Color.black
            .opacity(0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
          self.isShowing = false
        }
        mainView
          .transition(.move(edge: .bottom))
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .ignoresSafeArea()
    .animation(.easeInOut)
  }
  
  //MARK: - mainView
  var numbers: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  
  var mainView: some View{
    VStack(alignment: .center, spacing: 0) {
      
      ZStack(alignment: .center){
        Capsule()
          .frame(width: 48, height: 4)
          .foregroundColor(Color.black)
          .opacity(0.24)
      }
      .frame(height: 20)
      .frame(maxWidth: .infinity)
      .background(Color.white)
      .cornerRadius(20, corners: [.topLeft, .topRight])
      .gesture(dragGesture)
      
      ZStack(alignment: .center){
        VStack{
          ScrollView {
            ZStack(alignment: .topLeading) {
              Color.white
                .opacity(0.0)
                .clipShape(RoundedRectangle(cornerRadius: 12))
              
              Text(text ?? placeholder)
                .padding()
                .opacity(text == nil ? 1 : 0)
              TextEditor(text: Binding($text, replacingNilWith: ""))
                .frame(minHeight: 40, alignment: .leading)
                .frame(maxHeight: 130, alignment: .leading)
                .cornerRadius(6.0)
                .multilineTextAlignment(.leading)
                .padding(9)
                .background(GeometryReader { proxy in
                  Color.clear
                    .onChange(of: self.text, perform:
                                { value in
                      curHeight = proxy.size.height + 60
                      
                      self.minHeight = curHeight
                    })
                })
                .onChange(of: self.text) { newValue in
                  self.textLength = newValue?.count ?? 0
                }
                
            }
          }
          
          HStack{
            Text("\(textLength) / 150")
            Spacer()
            Button {
              print("send")
            } label: {
              Rectangle()
                .frame(width: 56, height: 32)
                .cornerRadius(4)
                .foregroundColor(textLength == 0 ? Color(hex: "#F2F1F1") : Color(hex: "E8F5E9"))
                .overlay{
                  Image(systemName: "paperplane.fill")
                    .foregroundColor(textLength == 0 ? Color(hex: "#919090") : Color(hex: "#43A046"))
                }
            }
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 4)
        }
      }// ZStack
      .frame(maxHeight: .infinity)
      .background(Color.white)
    }
    .frame(height: curHeight)
    .frame(maxWidth: .infinity)
    .animation(isDragging ? nil : .easeInOut(duration: 0.45))
    .offset(y: -self.keyboardHeightHelper.keyboardHeight)
  }
  
  
  @State private var prevDragTranslation = CGSize.zero
  
  
  var dragGesture: some Gesture{
    DragGesture(minimumDistance: 0, coordinateSpace: .global)
      .onChanged { val in
        if !isDragging {
          isDragging = true
        }
        
        let dragAmount = val.translation.height - prevDragTranslation.height
        
        if curHeight > (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight){
          curHeight -= dragAmount / 6
        }
        else if curHeight < minHeight {
          curHeight -= dragAmount / 6
        }
        else{
          curHeight -= dragAmount
        }
        
        prevDragTranslation = val.translation
      }
      .onEnded { gesture in
        prevDragTranslation = .zero
        isDragging = false
        if curHeight > minHeight + 40 {
          curHeight = (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight) * 0.9
        }
        else if curHeight < minHeight - 10{
          isShowing = false
          curHeight = minHeight
        }
        else {
          curHeight = minHeight
        }
        
//        let xDist =  abs(gesture.location.x - self.startPos.x)
//        let yDist =  abs(gesture.location.y - self.startPos.y)
//        if self.startPos.y <  gesture.location.y && yDist > xDist { // 아래 Gesture
//          curHeight = minHeight
//        }
//        else if self.startPos.y >  gesture.location.y && yDist > xDist {
//          curHeight = (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight) * 0.9
//        }
        
      }
  }
}


public extension Binding where Value: Equatable {
  
  init(_ source: Binding<Value?>, replacingNilWith nilProxy: Value) {
    self.init(
      get: { source.wrappedValue ?? nilProxy },
      set: { newValue in
        if newValue == nilProxy {
          source.wrappedValue = nil
        } else {
          source.wrappedValue = newValue
        }
      }
    )
  }
}


//struct MessageView_Previews: PreviewProvider {
//  static var previews: some View {
//    MessageView(.constant(true))
//  }
//}
