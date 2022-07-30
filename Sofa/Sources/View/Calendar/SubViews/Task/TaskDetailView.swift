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
  
  @State var isTitleFocused: Bool = false
  @State var isMemoFocused: Bool = false
  @State private var title: String = ""
  @State private var memo: String = ""
  @State private var allDayToggle = false
  @State var showDatePicker = false
  @State var currentDate: Date = Date()

  
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
        TaskColorPicker(selectedColor: task.color.toColorHex() ?? "#43A047")
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
              TaskTimePicker(time: task.time.toTime() ?? Date())
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
            // 업데이트
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
    }
  }
}

struct TaskDetailView_Previews: PreviewProvider {
  static var previews: some View {
    TaskDetailView(task: Task(allDay: true, date: "2022-07-20", time: "08:25", title: "회의", content: "전체회의", visibility: true, color: "BLUE")).environmentObject(TaskStore())
  }
}
