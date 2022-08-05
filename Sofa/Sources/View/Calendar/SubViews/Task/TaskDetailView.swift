//
//  TaskDetailView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/10.
//

import SwiftUI

struct TaskDetailView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var task: Task
  @EnvironmentObject var store: TaskStore
  
  @State var showDatePicker = false
  @State var showTimePicker = false
  @State var showColorPicker = false
  @State var isTitleFocused = false
  @State var isMemoFocused = false
  @State var isColorButtonClicked = false
  @State var selectedColor = "#43A047"
  @State var title = ""
  @State var memo = ""
  @State var allDayToggle = false
  @State var currentDate = Date()
  @State var time = Date()

  var taskDetailContent: some View {
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
              title = task.title
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
          .padding(EdgeInsets(top: 16, leading: 16, bottom: 12, trailing: 16))
        
        // 색상
        colorPicker
        Border()
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
                .onAppear{
                  allDayToggle = task.allDay
                }
              Spacer()
            }.padding(.bottom, 24)
            
            // 날짜
            GeneralDatePickerView(showDatePicker: $showDatePicker, enableToggle: .constant(true), currentDate: $currentDate)
              .padding(.bottom, 12)
              .onAppear {
                currentDate = task.date.toDateDay()!
              }
            
            if showDatePicker {
              Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color(hex: "EDEADF"))
                .padding(.top, 16)
            }
            
            // 시간
            if !allDayToggle {
              timePicker
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
            .onAppear{
              UITextView.appearance().backgroundColor = .clear
              memo = task.content
            }
          }
          Border()
        }
        Spacer().frame(height: 350)
      }
    }
  }
  
  var body: some View {
    ZStack{
      NavigationView{
        ZStack {
          Color.white.ignoresSafeArea()
          Color(hex: "FAF8F0").ignoresSafeArea()
            .padding(.top, Screen.maxHeight/3)
          ScrollView{
            VStack(spacing: 0) {
              Border()
              Rectangle()
                .frame(width: Screen.maxWidth, height: 7)
                .foregroundColor(Color(hex: "FAF8F0"))
              taskDetailContent
            }
          }
        }
        .navigationBarItems(
          leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }, label: {
            HStack(spacing: 0) {
              Image(systemName: "chevron.left")
              Text("이전")
                .font(.custom("Pretendard-Medium", size: 16))
                .fontWeight(.semibold)
            }
          })
          .accentColor(Color(hex: "#43A047"))
          .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
          trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            store.update(task: task, allDay: allDayToggle, date: currentDate.getFormattedDate(format: "yyyy-MM-dd"), time: time.getFormattedDate(format: "HH:mm"), title: title, content: memo, visibility: true, color: selectedColor)
          }, label: {
            Text("수정")
              .fontWeight(.semibold)
              .frame(height: 24)
              .font(.custom("Pretendard-Medium", size: 16))
              .foregroundColor(Color(.black).opacity(0.4))
          })
          .accentColor(Color(hex: "#43A047"))
          .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("일정 상세")
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
    }.onAppear{
      selectedColor = task.color
    }
  }
  
  var timePicker: some View {
    VStack{
      HStack(spacing: 0) {
        Image(systemName: "clock")
          .font(.system(size: 20))
          .frame(width: 24, height: 24)
          .foregroundColor(Color(hex:"4CAF50"))
          .padding(.trailing, 10)
        Text("시간")
          .font(.custom("Pretendard-Medium", size: 16))
          .foregroundColor(Color(hex: "121619"))
        Spacer()
        Text("\(time.getFormattedDate(format: "a hh:MM"))")
          .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
          .font(.custom("Pretendard-Medium", size: 13))
          .foregroundColor(Color(hex: "#43A047"))
          .frame(height: 28, alignment: .center)
          .background(Color(hex: "#E8F5E9"))
          .cornerRadius(4)
          .onTapGesture {
            withAnimation{
            self.showTimePicker.toggle()
            }
          }
      }
      if showTimePicker {
        DatePicker(selection: $time, displayedComponents: .hourAndMinute) {}
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
        .frame(width: 358)
      }
    }
  }
  
  var colorPicker: some View {
    VStack(spacing: 0){
      HStack(spacing: 0){
        Circle()
          .foregroundColor(Color(hex: selectedColor))
          .overlay(
            Circle()
              .stroke(.black.opacity(0.05), lineWidth: 1)
          )
          .padding(3)
          .overlay(
            Circle()
              .stroke(.black.opacity(0.05), lineWidth: 1)
          )
          .frame(width: 24, height: 24)
        
        Text("색상")
          .font(.custom("Pretendard-Medium", size: 16))
          .foregroundColor(Color(hex: "121619"))
          .padding(.leading, 10)
        
        Spacer()
        
        Button(action: {
          withAnimation {
            self.showColorPicker.toggle()
            self.isColorButtonClicked.toggle()
          }
        }) {
          Image(systemName: self.isColorButtonClicked ? "chevron.down" : "chevron.right" )
            .font(.system(size: 20))
            .frame(width: 24, height: 24)
            .foregroundColor(self.isColorButtonClicked ? Color(hex: "#121619") : Color(.black).opacity(0.4) )
        }
      }
      
      if showColorPicker {
        ColorCircles(selectedColor: $selectedColor)
          .padding(.top, 24)
        
        Rectangle()
          .foregroundColor(Color(hex: "#EDEADF"))
          .frame(height: 1)
          .padding(.top, 12)
          .padding(.bottom, 16)
      } else {
        Rectangle()
          .foregroundColor(Color.white)
          .frame(height: 28)
      }
    }
    .padding(.leading, 16)
    .padding(.trailing, 16)
  }
}

struct TaskDetailView_Previews: PreviewProvider {
  static var previews: some View {
    TaskDetailView(task: Task(allDay: true, date: "2022-07-20", time: "08:25", title: "회의", content: "전체회의", visibility: true, color: "BLUE")).environmentObject(TaskStore())
  }
}
