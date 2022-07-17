//
//  TaskDetailView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/10.
//

import SwiftUI

struct TaskDetailView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var isTitleFocused: Bool = false
  @State var isMemoFocused: Bool = false
  @State private var title: String = ""
  @State private var memo: String = ""
  @State private var allDayToggle = false
  @State var showDatePicker = false
  @State var currentDate: Date = Date()
  
  init() {
    UITextView.appearance().backgroundColor = .clear
  }
  
  var body: some View {
    ZStack {
      Color(.white).ignoresSafeArea()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 400, trailing: 0))
      Color(hex: "FAF8F0").ignoresSafeArea()
        .padding(EdgeInsets(top: 500, leading: 0, bottom: 0, trailing: 0))
      
      VStack(spacing: 0){
        HStack(spacing: 0){
          Text("이전")
            .frame(height: 24)
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color(hex: "43A047"))
            .padding(.leading, 24)
            .onTapGesture {
              self.presentationMode.wrappedValue.dismiss()
            }
          Spacer()
          
          Text("일정 상세")
            .frame(height: 24)
            .font(.custom("Pretendard-Bold", size: 16))
            .foregroundColor(Color(hex: "121619"))
          Spacer()
          
          Text("수정")
            .frame(height: 24)
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color(.black).opacity(0.4))
            .padding(.trailing, 24)
            .onTapGesture {
              self.presentationMode.wrappedValue.dismiss()
            }
        }
        
        Rectangle()
          .frame(width:Screen.maxWidth, height: 1)
          .foregroundColor(Color(hex: "EDEADF"))
          .padding(.top,9)
        Rectangle()
          .frame(width: Screen.maxWidth, height: 7)
          .foregroundColor(Color(hex: "FAF8F0"))
        
        ScrollView {
          LazyVStack(spacing: 0) {
            
            ZStack{
              TextField("", text: $title)
                .placeholder(shouldShow: title.isEmpty) {
                  Text("제목")
                    .font(.custom("Pretendard-Medium", size: 18))
                    .foregroundColor(Color(hex: "121619").opacity(0.4))
                }
                .customTextField(padding: 12)
                .disableAutocorrection(true)
                .background(isTitleFocused ? Color.white : Color(hex: "FAF8F0"))
                .cornerRadius(6)
                .highlightTextField(firstLineWidth: isTitleFocused ? 1 : 0, secondLineWidth: isTitleFocused ? 4 : 0)
                .onAppear {
                  UIApplication.shared.hideKeyboard()
                }
              
              UITextFieldRepresentable(
                text: $title,
                isFirstResponder: false,
                isNumberPad: false,
                isFocused: $isTitleFocused
              )
              .padding(.horizontal, 14)
            }.frame(height: 48)
              .padding(EdgeInsets(top: 25, leading: 16, bottom: 12, trailing: 16))
            
            // 색상
            TaskColorPicker()
            Rectangle()
              .frame(width:Screen.maxWidth, height: 1)
              .foregroundColor(Color(hex: "EDEADF"))
            Rectangle()
              .frame(width: Screen.maxWidth, height: 7)
              .foregroundColor(Color(hex: "FAF8F0"))
            
            Group {
              VStack(spacing: 0) {
                // 하루종일
                HStack(spacing: 0) {
                  Image(systemName: "hourglass.tophalf.filled")
                    .font(.system(size: 20))
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(hex:"4CAF50"))
                    .padding(.trailing, 10)
                  Text("하루 종일")
                    .font(.custom("Pretendard-Medium", size: 16))
                    .foregroundColor(Color(hex: "121619"))
                  Toggle("", isOn: $allDayToggle)
                  Spacer()
                }.padding(.bottom, 24)
                
                // 날짜
                GeneralDatePickerView(showDatePicker: $showDatePicker, enableToggle: .constant(true), currentDate: $currentDate)
                  .padding(.bottom, 12)
                
                if showDatePicker {
                  Rectangle()
                    .frame(height: 1.0, alignment: .bottom)
                    .foregroundColor(Color(hex: "EDEADF"))
                    .padding(.top, 16)
                }
                
                // 시간
                if !allDayToggle {
                  TaskTimePicker()
                    .padding(.bottom, 27)
                    .padding(.top, 12)
                }
              }.padding(EdgeInsets(top: 27, leading: 19.5, bottom: 0, trailing: 16))
              
              Rectangle()
                .frame(width: Screen.maxWidth, height: 1)
                .foregroundColor(Color(hex: "EDEADF"))
              Rectangle()
                .frame(width: Screen.maxWidth, height: 8)
                .foregroundColor(Color(hex: "FAF8F0"))
            }.background(Color.white)
            
            // 메모
            Group {
              ZStack {
                Rectangle()
                  .frame(width: Screen.maxWidth, height: 160)
                  .foregroundColor(Color.white)
                Rectangle()
                  .frame(height: 128)
                  .foregroundColor(isMemoFocused ? Color.white : Color(hex: "FAF8F0"))
                  .cornerRadius(6)
                  .highlightTextField(firstLineWidth: isMemoFocused ? 1 : 0, secondLineWidth: isMemoFocused ? 4 : 0)
                  .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                if memo.isEmpty {
                  VStack{
                    HStack{
                      Text("메모")
                        .font(.custom("Pretendard-Medium", size: 18))
                        .foregroundColor(Color.black.opacity(0.4))
                        .padding(.horizontal, 32)
                        .padding(.vertical, 30)
                      Spacer()
                    }
                    Spacer()
                  }
                }
                
                UITextViewRepresentable(
                  text: $memo,
                  isFirstResponder: false,
                  isNumberPad: false,
                  isFocused: $isMemoFocused
                )
                .frame(height: 116)
                .padding(.horizontal, 27)
              }
              
              Rectangle()
                .frame(width:Screen.maxWidth, height: 1)
                .foregroundColor(Color(hex: "EDEADF"))
            }
            Spacer()
          }
        }
      }
      .padding(.top, 9)
    }
  }
}

struct TaskDetailView_Previews: PreviewProvider {
  static var previews: some View {
    TaskDetailView()
  }
}
