//
//  MessageView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/11.
//

import SwiftUI
import Combine
import MbSwiftUIFirstResponder

enum FirstResponders: Int {
  case text
}

struct MessageView: View {
  
  @Binding var placeholder: String
  @StateObject var keyboardHeightHelper = KeyboardHeightHelper()
  
  @Binding var isShowing: Bool // 외부 View에서 MessageView 띄울 때 사용
  @Binding var text: String? // TextEditor의 Text
  @State private var isDragging = false
  @State private var textLength: Int = 0 // 글자 수 세기
  @State private var curHeight: CGFloat = 120 // View의 현재 높이
  @State var minHeight: CGFloat = 120 // View의 최소 높이
  @State var isMaxHeight: Bool = false // 현재 View가 MaxHeight인지 여부
  @State var keyboardHeight: CGFloat = 0
  @State var fullTextEditorHeight: CGFloat = 0 // TextEditor가 Full일 때 높이
  @State var isKeyboard: Bool = false // 현재 키보드 올라와있는지
  @State var firstResponder: FirstResponders? = Sofa.FirstResponders.text
  let callback: (() -> ())?

  init(_ isShowing: Binding<Bool>, _ text: Binding<String?>, _ placeholder: Binding<String>, callback: (() -> ())? = nil){
    UITextView.appearance().backgroundColor = .clear
    _isShowing = isShowing
    _text = text
    _placeholder = placeholder
    self.callback = callback
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
          .offset(y: -self.keyboardHeightHelper.keyboardHeight)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    .ignoresSafeArea()
    //    .animation(.easeInOut)
  }
  
  //MARK: - mainView
  var mainView: some View{
    VStack(alignment: .center, spacing: -1) {
      
      ZStack(alignment: .center){ // Panel
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
        VStack(spacing: 0){
          ScrollView {
            ZStack(alignment: .topLeading) {
              Color.white
                .opacity(0.0)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(height: 1)
              
              ZStack(alignment: .topLeading){
                Text(text ?? placeholder) // PlaceHolder
                  .font(.custom("Pretendard-Regular", size: 16))
                  .foregroundColor(Color(UIColor.placeholderText))
                  .padding(.horizontal, 12)
                  .padding(.vertical, 15)
                  .opacity(text == nil ? 1 : 0)
                TextEditor(text: Binding($text, replacingNilWith: ""))
                  .firstResponder(id: FirstResponders.text, firstResponder: $firstResponder, resignableUserOperations: .none)
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
                          curHeight = (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight)
                        }
                      })
                  })
                  .onChange(of: self.text) { newValue in
                    self.textLength = newValue?.count ?? 0
                  }
                  .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    self.curHeight = minHeight
                    isMaxHeight = false
                    isKeyboard = true
                  }
                  .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    isKeyboard = false
                  }
                
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
          
          HStack(alignment: .center){ // 글자 수
            HStack(spacing: 0){
              Group{
                Text("\(textLength)")
                  .foregroundColor(Color(hex: "43A047"))
                Text("/150")
                  .foregroundColor(Color(hex: "#999899"))
              }
              .font(.custom("Pretendard-Medium", size: 14))
            }
            Spacer()
            Button { // SEND BUTTON
              if textLength == 0{
                print("textLength == 0")
              }else{
                isShowing = false
                self.callback?()
              }
            } label: {
              ZStack{
                Rectangle()
                  .frame(width: 56, height: 32)
                  .cornerRadius(4)
                  .foregroundColor(textLength == 0 ? Color(hex: "#F2F1F1") : Color(hex: "E8F5E9"))
                Image(systemName: "paperplane.fill")
                  .resizable()
                  .foregroundColor(textLength == 0 ? Color(hex: "#919090") : Color(hex: "#43A046"))
                  .frame(width: 20, height: 20, alignment: .center)
                
              }
            }
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 4)
        }
      }// ZStack
      .frame(maxHeight: .infinity)
      .background(Color.white)
      if !isKeyboard{ // Notch 디바이스는 Radius때문에 하단이 잘리므로 Padding 추가
        Rectangle()
          .foregroundColor(.white)
          .frame(width: Screen.maxWidth, height: UIDevice().hasNotch ? 20 : 0)
      }
    }
    //    .offset(y: -self.keyboardHeightHelper.keyboardHeight)
    .frame(height: isKeyboard ? curHeight : curHeight + 20 )
    .frame(maxWidth: .infinity)
    .animation(isDragging ? nil : .easeInOut(duration: 0))
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
          curHeight = (Screen.maxHeight * 0.9 - self.keyboardHeightHelper.keyboardHeight)
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
