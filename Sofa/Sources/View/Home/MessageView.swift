//
//  MessageView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/11.
//

import SwiftUI

struct MessageView: View {
  
  @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
  
  @Binding var isShowing: Bool
  @State private var isDragging = false
  @State private var text: String = ""
  @State private var textLength: Int = 0
  @State private var textEditorHeight: CGFloat = 16
  
  @State private var curHeight: CGFloat = 112
  
  let minHeight: CGFloat = 112
  //  let maxHeight: CGFloat = (Screen.maxHeight - yoffset) * 0.9
  
  init(_ isShowing: Binding<Bool>){
    _isShowing = isShowing
  }
  
  var body: some View {
    ZStack(alignment: .bottom){
      if isShowing{
        VStack {
          Color.black
            .opacity(0.7)
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
          TextEditor(text: $text)
            .foregroundColor(Color.black)
            .font(.custom("Pretendard-Regular", size: 16))
            .padding(EdgeInsets(top: 4, leading: 26, bottom: 12, trailing: 26))
            .background(Color.yellow)
            .onChange(of: text) { value in
              textLength = value.count
            }
            .frame(minHeight: 30, alignment: .leading)

//            .background(GeometryReader { proxy in
//              Color.clear
//                .onChange(of: self.text, perform: { value in
////                  if proxy.size.height > textEditorHeight {
////                    textEditorHeight = proxy.size.height + 17.0
////                  }
////                  print(proxy.size.height)
////                  print(textEditorHeight)
//                  curHeight += textEditorHeight
//                })
//
//            })
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
        
        if curHeight > (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight) || curHeight < minHeight {
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
          curHeight = (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight) * 0.9
        }
        else {
          curHeight = minHeight
        }
        //        else if curHeight < minHeight - 35{
        //          isShowing = false
        //          curHeight = minHeight
        //        }
        
      }
  }
}



struct MessageView_Previews: PreviewProvider {
  static var previews: some View {
    MessageView(.constant(true))
  }
}
