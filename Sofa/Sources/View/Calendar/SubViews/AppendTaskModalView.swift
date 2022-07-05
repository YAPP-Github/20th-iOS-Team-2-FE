//
//  AppendTaskModalView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/28.
//

import SwiftUI

struct AppendTaskModalView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var title: String = ""
  @State var memo: String = ""
  
  @State private var allDayToggle = false
  
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
        
        // indicator
        Rectangle()
          .frame(width: 48, height: 4)
          .foregroundColor(Color(hex: "000000").opacity(0.24))
          .cornerRadius(80)
          .padding(.top, 8)
        
        // 취소, 새로운일정, 완료
        HStack(spacing: 0){
          Text("취소")
            .frame(height: 24)
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color(hex: "43A047"))
            .padding(.leading, 24)
            .onTapGesture {
              self.presentationMode.wrappedValue.dismiss()
            }
          Spacer()
          
          Text("새로운 일정")
            .frame(height: 24)
            .font(.custom("Pretendard-Bold", size: 16))
            .foregroundColor(Color(hex: "121619"))
          Spacer()
          
          Text("완료")
            .frame(height: 24)
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color(.black).opacity(0.4))
            .padding(.trailing, 24)
            .onTapGesture {
              self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding(.top, 17)
        
        ScrollView {
          LazyVStack(spacing: 0) {
            // 제목
            Group {
              TextField("", text: $title)
                .placeholder(shouldShow: title.isEmpty) {
                  Text("제목")
                    .font(.custom("Pretendard-Medium", size: 18))
                    .foregroundColor(Color(hex: "121619").opacity(0.4))
                }
                .customTextField(padding: 12)
                .frame(height: 48)
                .background(Color(hex: "FAF8F0"))
                .padding(EdgeInsets(top: 25, leading: 16, bottom: 12, trailing: 16))
                .cornerRadius(6)
            }
            
            // 색상
            HStack(spacing: 0){
              Circle()
                .foregroundColor(Color(hex: "4CAF50"))
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
                .padding(.leading, 16)
              
              Text("색상")
                .font(.custom("Pretendard-Medium", size: 16))
                .foregroundColor(Color(hex: "121619"))
                .padding(.leading, 10)
              
              Spacer()
              
              Button(action: {
                
              }) {
                Image(systemName: "chevron.right")
                  .font(.system(size: 20))
                  .frame(width: 24, height: 24)
                  .foregroundColor(Color(.black).opacity(0.4))
                  .padding(.trailing, 16)
              }
              
            }
            .padding(.bottom, 28)
            Rectangle()
              .frame(width:Screen.maxWidth, height: 1)
              .foregroundColor(Color(hex: "EDEADF"))
            Rectangle()
              .frame(width: Screen.maxWidth, height: 7)
              .foregroundColor(Color(hex: "FAF8F0"))
            
            // 하루종일, 날짜, 시간
            Group {
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
                // TODO: - 이름 변경
                tmpView()
                  .padding(.bottom, 12)
                
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
                  Text("오후 HH-MM")
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .font(.custom("Pretendard-Medium", size: 13))
                    .foregroundColor(Color(hex: "121619"))
                    .frame(height: 28, alignment: .center)
                    .background(Color.black.opacity(0.02))
                    .cornerRadius(4)
                }
              }.padding(EdgeInsets(top: 30, leading: 19.5, bottom: 27, trailing: 16))
              
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
                  .foregroundColor(Color(hex: "FAF8F0"))
                  .cornerRadius(6)
                  .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                TextEditor(text: $memo)
                  .placeholder(shouldShow: memo.isEmpty) {
                    Text("메모")
                      .font(.custom("Pretendard-Medium", size: 18))
                      .foregroundColor(Color.black.opacity(0.4))
                      .padding(EdgeInsets(top: 10, leading: 3, bottom: 0, trailing: 16))
                      .frame(height: 128, alignment: .topLeading)
                  }
                  .customTextField(padding: 9)
                  .foregroundColor(Color(hex: "121619"))
                  .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                  .frame(height: 128, alignment: .center)
              }
              Rectangle()
                .frame(width:Screen.maxWidth, height: 1)
                .foregroundColor(Color(hex: "EDEADF"))
              
            }
            
            Spacer()
          }
        }
      }
    }
  }
}

struct AppendTaskModalView_Previews: PreviewProvider {
  static var previews: some View {
    //CalendarView()
    AppendTaskModalView()
  }
}
