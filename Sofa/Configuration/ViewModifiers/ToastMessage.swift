//
//  ToastMessage.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/27.
//

import SwiftUI

struct ToastMessage: ViewModifier {
  @Binding var data: MessageData
  @Binding var isShow: Bool
  
  struct MessageData {
    var title: String
    var type: MessageType
  }
  
  enum MessageType {
    case Registration // 즐겨찾기, 다운로드, 대표 사진
    case Warning      // 사진 선택
    case Remove       // 사진 제거
    
    var iconColor: Color {
      switch self {
      case .Registration:
        return Color(hex: "#FFCA28") // 임시
      case .Warning:
        return Color(hex: "#33B1FF") // 임시
      case .Remove:
        return Color(hex: "#EC407A") // 임시
      }
    }
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if isShow {
        VStack {
          HStack {
            Image(systemName: "info.circle.fill")
              .foregroundColor(data.type.iconColor)
            Text(data.title)
              .font(.system(size: 16, weight: .semibold))
          }
          .foregroundColor(Color.white)
          .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
          .background(Color(hex: "#262626")) // 임시
          .cornerRadius(80)
          Spacer()
        }
        .padding(.top, 11)
        .animation(.easeInOut) // 점점 빨라졌다 끝에가서 다시 느려지는 옵션
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onTapGesture {
          withAnimation { // click하면 사라짐
            self.isShow = false
          }
        }.onAppear(perform: {
          DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 3초
            withAnimation {
              self.isShow = false
            }
          }
        })
      }
    }
  }
}

extension View {
  func toastMessage(data: Binding<ToastMessage.MessageData>, isShow: Binding<Bool>) -> some View {
    self.modifier(ToastMessage(data: data, isShow: isShow))
  }
}

struct toastMessage_Previews: PreviewProvider {
  static var previews: some View {
    let messageData: ToastMessage.MessageData = ToastMessage.MessageData(title: "즐겨찾기 등록", type: .Registration)
    
    Color.gray
      .edgesIgnoringSafeArea(.all)
      .toastMessage(data: .constant(messageData), isShow: .constant(true))
  }
}
