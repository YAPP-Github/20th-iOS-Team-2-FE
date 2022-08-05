//
//  RegisterFinishView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/13.
//

import SwiftUI
import SwiftKeychainWrapper

struct RegisterFinishView: View {
  
  @Binding var accessToken: String
  @Binding var userId: Int
  @State var showFamilyRegister: Bool = false
  @State var showEnterCode: Bool = false
  
  var body: some View {
    VStack(spacing: 0){
      ZStack{
        Rectangle()
          .ignoresSafeArea()
          .frame(height: 191-34)
          .foregroundColor(Color(hex: "#388E3C"))
        VStack(spacing: 0){
          Text("회원가입 완료!")
            .font(.custom("Pretendard-Bold", size: 28))
            .foregroundColor(Color.white)
            .frame(height: 42)
          Text("Sofa의 회원가입을 완료했어요.")
            .font(.custom("Pretendard-Medium", size: 20))
            .foregroundColor(Color.white.opacity(0.5))
            .padding(.top, 8)
            .frame(height: 30)
        }
        .onAppear{
          Constant.accessToken = accessToken
          Constant.userId = userId
          KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
          KeychainWrapper.standard.set(userId, forKey: "userId")
          print("RegisterFinishView AccessToken: \(Constant.accessToken ?? "")")
          print("RegisterFinishView userId: \(Constant.userId ?? 0)")
        }
      }
      Button(action: {
        self.showFamilyRegister = true
      }){
        Image("cta")
      }
      .fullScreenCover(isPresented: $showFamilyRegister, content: RegisterFamilyView.init)
      .padding(.top, 16)
      
      Button(action: {
        self.showEnterCode = true
      }){
        Image("code")
      }
      .fullScreenCover(isPresented: $showEnterCode, content: EnterCodeView.init)
      .padding(.top, 10)
      
      Image("alert")
        .padding(.top, 10)
      Spacer()
    }
  }
}

struct RegisterFinishView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterFinishView(accessToken: .constant(""), userId: .constant(0))
  }
}
