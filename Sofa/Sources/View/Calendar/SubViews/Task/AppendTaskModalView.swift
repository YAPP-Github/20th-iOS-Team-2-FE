//
//  AppendTaskModalView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/28.
//

import SwiftUI

struct AppendTaskModalView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @EnvironmentObject var store: TaskStore
  
  @State var isTitleFocused: Bool = false
  @State var isMemoFocused: Bool = false
  
  @State var title = ""
  @State var memo = ""
  @State var allDayToggle = false
  @State var currentDate = Date()
  @State var showDatePicker = false
  @State var color = "#43A047"
  @State var time = Date()
  var task: Task? = nil
  
  var appendTaskContent: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        // 제목
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
            .modifier(DismissingKeyboard())
            .onAppear {
              UIApplication.shared.hideKeyboard()
            }
          
          UITextFieldRepresentable(
            text: $title,
            isFirstResponder: true,
            isNumberPad: false,
            isFocused: $isTitleFocused
          )
          .padding(.horizontal, 14)
        }.frame(height: 48)
          .padding(EdgeInsets(top: 25, leading: 16, bottom: 12, trailing: 16))
        
        // 색상
        TaskColorPicker(selectedColor: "#43A047")
        Border()
        Rectangle()
          .frame(width: Screen.maxWidth, height: 7)
          .foregroundColor(Color(hex: "FAF8F0"))
        
        Group {
          // 하루종일
          VStack(spacing: 0) {
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
              TaskTimePicker(time: Date())
                .padding(.bottom, 27)
                .padding(.top, 12)
            }
          }.padding(EdgeInsets(top: 30, leading: 19.5, bottom: 0, trailing: 16))
          
          Border()
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
              isFirstResponder: true,
              isNumberPad: false,
              isFocused: $isMemoFocused
            )
            .frame(height: 116)
            .padding(.horizontal, 27)
            .onAppear{
              UITextView.appearance().backgroundColor = .clear
            }
          }
          Border()
        }
        Spacer().frame(height: 350)
      }
    }
  }
  
  var body: some View {
    NavigationView{
      ZStack {
        Color.white.ignoresSafeArea()
        Color(hex: "FAF8F0").ignoresSafeArea()
          .padding(.top, Screen.maxHeight/3)
        ScrollView{
          VStack{
            appendTaskContent
            Spacer()
          }
        }
      }
      .navigationBarItems(
        leading: Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }, label: {
          Text("취소")
            .font(.custom("Pretendard-Medium", size: 16))
            .fontWeight(.semibold)
            .frame(height: 24)
            .padding(.top, 23)
        })
        .accentColor(Color(hex: "#43A047"))
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          self.presentationMode.wrappedValue.dismiss()
          store.insert(allDay: allDayToggle, date: currentDate.getFormattedDate(format: "yyyy-MM-dd"), time: time.getFormattedDate(format: "HH:mm"), title: title, content: memo, visibility: true, color: color)
        }, label: {
          Text("완료")
            .fontWeight(.semibold)
            .frame(height: 24)
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color(.black).opacity(0.4))
            .padding(.top, 23)
        })
        .accentColor(Color(hex: "#43A047"))
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .principal) {
          VStack(spacing: 17) {
            Rectangle()
              .frame(width: 48, height: 4)
              .foregroundColor(Color(hex: "000000").opacity(0.24).opacity(0.5))
              .cornerRadius(80)
              .padding(.top, 2)
            Text("새로운 일정")
              .frame(height: 24)
              .font(.custom("Pretendard-Bold", size: 16))
              .foregroundColor(Color(hex: "121619"))
          }
        }
      }
      .onAppear {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor =
        UIColor.systemBackground.withAlphaComponent(1)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
      }
      .edgesIgnoringSafeArea([.bottom]) 
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarHidden(true)
  }
}

struct UITextViewRepresentable: UIViewRepresentable {
  @Binding var text: String
  var isFirstResponder: Bool = false
  var isNumberPad: Bool = false
  @Binding var isFocused: Bool
  
  func makeUIView(context: UIViewRepresentableContext<UITextViewRepresentable>) -> UITextView {
    let textField = UITextView(frame: .zero)
    textField.delegate = context.coordinator
    textField.textColor = UIColor(hex: "#121619")
    textField.autocorrectionType = .no
    textField.font = UIFont(name: "Pretendard-Medium", size: 18)
    if isNumberPad { textField.keyboardType = .numberPad
    }
    
    return textField
  }
  
  func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewRepresentable>) {
    uiView.text = self.text
    if isFirstResponder && !context.coordinator.didFirstResponder {
      uiView.becomeFirstResponder()
      context.coordinator.didFirstResponder = true
    }
    if isNumberPad { uiView.keyboardType = .numberPad
    }
  }
  
  func makeCoordinator() -> UITextViewRepresentable.Coordinator {
    Coordinator(text: self.$text, isFocused: self.$isFocused)
  }
  
  class Coordinator: NSObject, UITextViewDelegate {
    @Binding var text: String
    @Binding var isFocused: Bool
    var didFirstResponder = false
    var isNumberPad = false
    
    init(text: Binding<String>, isFocused: Binding<Bool>) {
      self._text = text
      self._isFocused = isFocused
    }
    
    func textViewDidChangeSelection(_ textField: UITextView) {
      self.text = textField.text ?? ""
    }
    
    func textViewShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      
      return true
    }
    
    func textViewDidBeginEditing(_ textField: UITextView) {
      self.isFocused = true
    }
    
    func textViewDidEndEditing(_ textField: UITextView) {
      self.isFocused = false
    }
  }
}

//struct AppendTaskModalView_Previews: PreviewProvider {
//  static var previews: some View {
//    AppendTaskModalView(, color: <#String#>)
//  }
//}
