//
//  RegisterFamilyView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/13.
//

import SwiftUI

struct RegisterFamilyView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var showFinishModal: Bool = false
  @State var text: String = ""
  @State var currentSteps: Int = 1
  @State var familyInfo = [String](repeating: "", count: 2)
  @State var isTextFocused: Bool = false
  
  let placeHolderText = [
    "소중한 우리가족",
    "착하게 살자"
  ]
  
  var body: some View {
    VStack(spacing: 0){
      ZStack{
        HStack(spacing: 0){
          Image(systemName: "chevron.left")
            .font(.system(size: 20))
            .foregroundColor(Color(hex: "#43A047"))
            .padding(.leading, 24)
            .contentShape(Rectangle())
            .onTapGesture {
              text = ""
              if currentSteps > 1 {
                currentSteps -= 1
              } else {
                self.presentationMode.wrappedValue.dismiss()
              }
            }
          Text("이전")
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color(hex: "#43A047"))
            .padding(.leading, 4)
          Spacer()
        }///HStack
        
        StepCircles(currentSteps: $currentSteps, numOfSteps: .constant(3))
      }.padding(.top, 9)
      
      switch currentSteps {
      case 1:
        Text("우리 가족 공간만의\n특별한 이름을 지어주세요.")
          .modifier(RegisterTextModifier())
      default:
        Text("우리집 가훈,\n한마디로 표현한다면?")
          .modifier(RegisterTextModifier())
      }
      
      Rectangle()
        .frame(width: Screen.maxWidth, height: 1)
        .foregroundColor(Color.black.opacity(0.1))
      
      // 텍스트필드
      ZStack{
        TextField("", text: $text)
          .placeholder(shouldShow: text.isEmpty) {
            Text(placeHolderText[currentSteps-1])
              .font(.custom("Pretendard-Medium", size: 18))
              .foregroundColor(Color(hex: "121619").opacity(0.4))
          }
          .disableAutocorrection(true)
          .customTextField(padding: 12)
          .frame(height: 48)
          .background(isTextFocused ? Color.white : Color(hex: "FAF8F0"))
          .cornerRadius(6)
          .highlightTextField(firstLineWidth: isTextFocused ? 1 : 0, secondLineWidth: isTextFocused ? 4 : 0)
        
        // Focus 감지를 위한 UITextField
        UITextFieldRepresentable(
          text: $text,
          isFirstResponder: true,
          isNumberPad: false,
          isFocused: $isTextFocused
        )
        .frame(height: 48)
        .padding(.horizontal, 16)
        .disabled(currentSteps == 2)
        
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
      .onAppear {
        UIApplication.shared.hideKeyboard()
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
        if !text.isEmpty {
          familyInfo[currentSteps-1] = text
          text = ""
          if currentSteps == 1 {
            currentSteps += 1
          } else {
            showFinishModal.toggle()
          }
        }
      }
      .fullScreenCover(isPresented: $showFinishModal, content: RegisterFamilyFinishView.init)
    }
    .padding(.bottom, 8+34)
  }
}


struct RegisterFamilyView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterFamilyView()
  }
}
