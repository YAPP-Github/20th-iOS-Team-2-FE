//
//  MessageView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/11.
//

import SwiftUI
import Combine

struct MessageView: View {
  
  let placeholder = "가족에게 인사를 남겨보세요."
  @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
  
  @Binding var isShowing: Bool
  @State private var isDragging = false
  @State private var text: String?
  @State private var textLength: Int = 0
  @State private var curHeight: CGFloat = 120
  @State var minHeight: CGFloat = 120
  @State var isMaxHeight: Bool = false
  @State var keyboardHeight: CGFloat = 0
  @State var fullTextEditorHeight: CGFloat = 0
  
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
  var mainView: some View{
    VStack(alignment: .center, spacing: -1) {
      
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
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(height: 1)
              
              ZStack(alignment: .leading){
                Text(text ?? placeholder)
                  .font(.custom("Pretendard-Regular", size: 16))
                  .padding()
                  .opacity(text == nil ? 1 : 0)
                TextEditor(text: Binding($text, replacingNilWith: ""))
                  .font(.custom("Pretendard-Regular", size: 16))
                  .frame(minHeight: isMaxHeight ? fullTextEditorHeight : 44, alignment: .leading)
                  .frame(maxHeight: isMaxHeight ? fullTextEditorHeight : 130, alignment: .leading)
                  .cornerRadius(6.0)
                  .multilineTextAlignment(.leading)
                  .padding(9)
                  .background(GeometryReader { proxy in
                    Color.clear
                      .onChange(of: self.text, perform:
                                  { value in
                        if !isMaxHeight{
                          curHeight = proxy.size.height + 58
                          self.minHeight = curHeight
                        }else{
                          curHeight = (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight) * 0.9
                        }
                      })
                  })
                  .onChange(of: self.text) { newValue in
                    self.textLength = newValue?.count ?? 0
                  }
                  .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    self.curHeight = minHeight
                    isMaxHeight = false
                  }
                  .foregroundColor(Color.black)
                  .background(Color.white).opacity(0.5)
              }
              .frame(minHeight: isMaxHeight ? fullTextEditorHeight : 44, alignment: .leading)
              .frame(maxHeight: isMaxHeight ? fullTextEditorHeight : 130, alignment: .leading)
            }
          }
          .background(GeometryReader { proxy in
            Color.clear
              .onChange(of: self.curHeight, perform:
                          { value in
                if (isMaxHeight){
                  self.fullTextEditorHeight = proxy.size.height
                }
              })
          })

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
        if curHeight > minHeight + 120 {
          curHeight = (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight) * 0.9
          isMaxHeight = true
        }
        else if curHeight < minHeight - 30{
          isShowing = false
          curHeight = minHeight
          isMaxHeight = false
        }
        else {
          curHeight = minHeight
          isMaxHeight = false
        }

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

extension View {
  func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
       if conditional {
           return AnyView(content(self))
       } else {
           return AnyView(self)
       }
   }
}
