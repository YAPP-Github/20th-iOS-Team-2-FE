//
//  RegisterView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/10.
//

import SwiftUI

struct RegisterView: View {
  
  @State var text: String = ""
  @State var currentSteps: Int = 1
  @FocusState var isTextFocused: Bool
  
  @State var info = [String](repeating: "", count: 4)
  
  var body: some View {
    VStack(spacing: 0){
      
      StepCircles(currentSteps: $currentSteps)
        .padding(.top, 9)

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
      Group {
        ZStack{
        TextField("", text: $text)
          .placeholder(shouldShow: text.isEmpty) {
            switch currentSteps {
            case 1:
              Text("홍길동")
                .font(.custom("Pretendard-Medium", size: 18))
                .foregroundColor(Color(hex: "121619").opacity(0.4))
            case 2:
              Text("역할 선택")
                .font(.custom("Pretendard-Medium", size: 18))
                .foregroundColor(Color(hex: "121619").opacity(0.4))
            case 3:
              Text("1990-01-1")
                .font(.custom("Pretendard-Medium", size: 18))
                .foregroundColor(Color(hex: "121619").opacity(0.4))
            default:
              Text("이쁜 딸, 효도할 놈")
                .font(.custom("Pretendard-Medium", size: 18))
                .foregroundColor(Color(hex: "121619").opacity(0.4))
            }
          }
          .customTextField(padding: 12)
          .disableAutocorrection(true)
          .frame(height: 48)
          .background(isTextFocused ? Color.white : Color(hex: "FAF8F0"))
          .cornerRadius(6)
          .highlightTextField(firstLineWidth: isTextFocused ? 1 : 0, secondLineWidth: isTextFocused ? 4 : 0)
          .focused($isTextFocused)
          .keyboardType(currentSteps == 3 ? .numberPad : .default)
          .onAppear {
            UIApplication.shared.hideKeyboard()
          }
          .onChange(of: text) { newValue in
            print("\(text)")
            if currentSteps == 3 {
              if text.count == 4 {
                text = text+"-"
              }
              if text.count == 7 {
                text = text+"-"
              }
            }
          }
          
          // 아이콘 X
          HStack{
            Spacer()
            Image(systemName: "xmark")
              .font(.system(size: 20))
              .foregroundColor(Color.black.opacity(isTextFocused && !text.isEmpty ? 0.4 : 0))
              .padding(.trailing, 12)
              .contentShape(Rectangle())
              .onTapGesture {
                text = ""
              }
          }
        }///ZStack
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
      }///Group
      
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
        if !text.isEmpty {
          info[currentSteps-1] = text
          print("\(info[currentSteps-1])")
          text = ""
          if currentSteps == 4 {
            currentSteps = 1
          } else {
            currentSteps += 1
          }
        }
      }
      .padding(.bottom, 8)
    }///VStack
  }
}

struct RegisterView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterView()
  }
}

struct RegisterTextModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.custom("Pretendard-Bold", size: 28))
      .frame(width: Screen.maxWidth-32, height: 84, alignment: .topLeading)
      .padding(.top, 25)
      .padding(.bottom, 16)
  }
}
