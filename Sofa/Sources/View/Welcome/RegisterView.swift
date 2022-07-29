//
//  RegisterView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/10.
//

import SwiftUI

struct UITextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    var isFirstResponder: Bool = false
    var isNumberPad: Bool = false
    @Binding var isFocused: Bool
    
  func makeUIView(context: UIViewRepresentableContext<UITextFieldRepresentable>) -> UITextField {
    let textField = UITextField(frame: .zero)
    textField.delegate = context.coordinator
    textField.textColor = UIColor.clear
    textField.autocorrectionType = .no
    if isNumberPad { textField.keyboardType = .numberPad
    }
    
    return textField
  }
  
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<UITextFieldRepresentable>) {
        uiView.text = self.text
        if isFirstResponder && !context.coordinator.didFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didFirstResponder = true
        }
      if isNumberPad { uiView.keyboardType = .numberPad
      }
    }
    
    func makeCoordinator() -> UITextFieldRepresentable.Coordinator {
      Coordinator(text: self.$text, isFocused: self.$isFocused)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isFocused: Bool
        var didFirstResponder = false
        var isNumberPad = false
        
      init(text: Binding<String>, isFocused: Binding<Bool>) {
            self._text = text
            self._isFocused = isFocused
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
          
          return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.isFocused = true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.isFocused = false
        }
    }
}

struct RegisterView: View {
  
  @EnvironmentObject var registerViewModel: RegisterViewModel
  
  @State var text: String = ""
  @State var currentSteps: Int = 1
  @State var showingSheet: Bool = false
  @State var showFinishModal: Bool = false
  @State var info = [String](repeating: "", count: 4)
  @State var isTextFocused: Bool = false
  @Binding var accessToken: String
  
  let placeHolderText = [
    "홍길동",
    "역할 선택",
    "1990-01-01",
    "이쁜 딸, 효도할 놈"
  ]
  
  var actionSheetView: some View {
    RoleActionSheet(
      isShowing: $showingSheet,
      items: [
        RoleActionSheetItem(label: "아빠") {
          showingSheet = false
          text = "아빠"
        },
        RoleActionSheetItem(label: "엄마") {
          showingSheet = false
          text = "엄마"
        },
        RoleActionSheetItem(label: "할아버지") {
          showingSheet = false
          text = "할아버지"
        },
        RoleActionSheetItem(label: "할머니") {
          showingSheet = false
          text = "할머니"
        },
        RoleActionSheetItem(label: "아들") {
          showingSheet = false
          text = "아들"
        },
        RoleActionSheetItem(label: "딸") {
          showingSheet = false
          text = "딸"
        },
        RoleActionSheetItem(label: "사위") {
          showingSheet = false
          text = "사위"
        },
        RoleActionSheetItem(label: "며느리") {
          showingSheet = false
          text = "며느리"
        }
      ],
      outOfFocusOpacity: 0.2,
      itemsSpacing: 0
    )
    .onDisappear {
      UITabBar.showTabBar()
    }
  }
  
  var body: some View {
    NavigationView {
      ZStack{
        VStack(spacing: 0){
          ZStack{
            if currentSteps > 1 {
              HStack(spacing: 0){
                Image(systemName: "chevron.left")
                  .font(.system(size: 20))
                  .foregroundColor(Color(hex: "#43A047"))
                  .padding(.leading, 24)
                  .contentShape(Rectangle())
                  .onTapGesture {
                    text = ""
                    currentSteps -= 1
                  }
                Text("이전")
                  .font(.custom("Pretendard-Medium", size: 16))
                  .foregroundColor(Color(hex: "#43A047"))
                  .padding(.leading, 4)
                Spacer()
              }///HStack
            }///if-end
            
            StepCircles(currentSteps: $currentSteps, numOfSteps: .constant(4))
          }.padding(.top, 9)
          
          switch currentSteps {
          case 1:
            Text("성함을 알려주세요")
              .modifier(RegisterTextModifier())
          case 2:
            Text("가족 내에서\n나는 어떤 역할인가요?")
              .modifier(RegisterTextModifier())
          case 3:
            Text("생년월일을\n알려주세요")
              .modifier(RegisterTextModifier())
          default:
            Text("가족에게 보여질\n멋진 별명을 지어주세요.")
              .modifier(RegisterTextModifier())
          }
          
          Rectangle()
            .frame(width: Screen.maxWidth, height: 1)
            .foregroundColor(Color.black.opacity(0.1))
         
          // 텍스트필드
            ZStack{
              TextField("", text: $text)
                .placeholder(shouldShow: text.isEmpty) {
                  switch currentSteps {
                  case 1,3,4:
                    Text(placeHolderText[currentSteps-1])
                      .font(.custom("Pretendard-Medium", size: 18))
                      .foregroundColor(Color(hex: "121619").opacity(0.4))
                  default:
                    Text("역할 선택")
                      .font(.custom("Pretendard-Medium", size: 18))
                      .foregroundColor(Color(hex: "121619").opacity(text.isEmpty ? 0.4 : 1))
                  }
                }
                .customTextField(padding: 12)
                .disableAutocorrection(true)
                .frame(height: 48)
                .background(isTextFocused ? Color.white : Color(hex: "FAF8F0"))
                .disabled(currentSteps == 2)
                .keyboardType(currentSteps == 3 ? .numberPad : .default)
                .cornerRadius(6)
                .highlightTextField(firstLineWidth: isTextFocused || showingSheet ? 1 : 0, secondLineWidth: isTextFocused || showingSheet ? 4 : 0)
              
              // Focus 감지를 위한 UITextField
              Group {
                if currentSteps == 3 {
                  UITextFieldRepresentable(
                    text: $text,
                    isFirstResponder: true,
                    isNumberPad: true,
                    isFocused: $isTextFocused
                  )
                } else {
                  UITextFieldRepresentable(
                    text: $text,
                    isFirstResponder: true,
                    isNumberPad: false,
                    isFocused: $isTextFocused
                  )
                }
              }
              .frame(height: 48)
              .padding(.horizontal, 16)
              .disabled(currentSteps == 2)

              // 텍스트필드 내 아이콘 X와 V
              HStack{
                Spacer()
                if currentSteps == 2 {
                  Image(systemName: "chevron.down")
                    .font(.system(size: 20))
                    .foregroundColor(Color(hex: "#121619"))
                    .padding(.trailing, 12)
                    .contentShape(Rectangle())
                    .onTapGesture {
                      self.showingSheet.toggle()
                    }
                } else {
                  Image(systemName: "xmark")
                    .font(.system(size: 20))
                    .foregroundColor(Color.black.opacity(isTextFocused && !text.isEmpty ? 0.4 : 0))
                    .padding(.trailing, 12)
                    .contentShape(Rectangle())
                    .onTapGesture {
                      text = ""
                    }
                }
              }
              
            }///ZStack
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            .onTapGesture {
              if currentSteps == 2 {
                self.showingSheet.toggle()
              }
            }
            .onAppear {
              UIApplication.shared.hideKeyboard()
            }
            .onChange(of: text) { newValue in
              if currentSteps == 3 {
                if text.count == 4 {
                  text = text+"-"
                }
                if text.count == 7 {
                  text = text+"-"
                }
              }
            }
          
          Spacer()
          
          // 다음
          ZStack{
            Rectangle()
              .frame(width: 358, height: 48)
              .foregroundColor(Color(hex: text.isEmpty ? "#A8A8A8" : "#43A047"))
              .cornerRadius(6)
            HStack(spacing: 8){
              Text("다음")
                .font(.custom("Pretendard-Regular", size: 18))
                .foregroundColor(Color.white.opacity(text.isEmpty ? 0.5 : 1))
              Image(systemName: "arrow.right")
                .font(.system(size: 20))
                .foregroundColor(Color.white.opacity(text.isEmpty ? 0.5 : 1))
            }///HStack
          }///ZStack
          .contentShape(Rectangle())
          .onTapGesture {
            print("\(placeHolderText[currentSteps-1])")
            if !text.isEmpty {
              info[currentSteps-1] = text
              text = ""
              if currentSteps == 4 {
                RegisterViewModel.register(name: info[0], roleInFamily: roleInFamily, birthDay: birthDay, nickname: nickname)
                showFinishModal.toggle()
              } else {
                currentSteps += 1
              }
            }
          }
          .fullScreenCover(isPresented: $showFinishModal, content: RegisterFinishView.init)
        }
          .padding(.bottom, 8+34)
          .navigationBarHidden(true)
        
        actionSheetView
      }
    }
  }
}

//struct RegisterView_Previews: PreviewProvider {
//  static var previews: some View {
//    RegisterView()
//  }
//}

struct RegisterTextModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.custom("Pretendard-Bold", size: 28))
      .frame(width: Screen.maxWidth-32, height: 84, alignment: .topLeading)
      .padding(.top, 25)
      .padding(.bottom, 16)
  }
}
