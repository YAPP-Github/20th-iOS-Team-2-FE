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
    case Registration // 즐겨찾기
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
          .background(Color(hex: "#262626"))
          .cornerRadius(80)
          Spacer()
        }
        .padding(.top, 100)
      }
    }
  }
}
}

struct toastMessage_Previews: PreviewProvider {
  static var previews: some View {
    ToastMessage()
  }
}
