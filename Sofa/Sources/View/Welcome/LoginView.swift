//
//  LoginView.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/04.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth

struct LoginView: View {
  
  @State var show = false
  @State var delay = 3
  var body: some View {
    VStack(spacing: -120){
      Spacer()
      if show{
        VStack{
          Text("우리 가족만의 공간")
            .font(.system(size: 28))
          Text("Sofa")
            .font(.system(size: 32))
        }
        .animation(.easeInOut(duration: 1))
        .transition(.move(edge: .top))
        .foregroundColor(Color(hex: "FAF8F0"))
      }else{
        VStack{
          Text("우리 가족만의 공간")
            .font(.system(size: 28))
          Text("Sofa")
            .font(.system(size: 32))
        }
        .animation(.default)
        .transition(.move(edge: .top))
        .foregroundColor(Color(hex: "FAF8F0"))
        .opacity(0)
      }
      LottieView(filename: "15025-bed")
        .frame(width: UIScreen.main.bounds.width, height: 400)
      Spacer()
    }//VStack
    .background(Color(hex: "29662C"))
    .ignoresSafeArea()
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        self.show = true
      }
    }
  }
  
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}


