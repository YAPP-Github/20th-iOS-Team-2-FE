//
//  RegisterFamilyFinishView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/13.
//

import SwiftUI

struct RegisterFamilyFinishView: View {
    var body: some View {
      
      VStack(spacing: 0){
        ZStack{
          Rectangle()
            .ignoresSafeArea()
            .frame(height: 191-34)
            .foregroundColor(Color(hex: "#388E3C"))
          
          VStack(spacing: 0){
            Text("가족 공간 생성 완료!")
              .font(.custom("Pretendard-Bold", size: 28))
              .foregroundColor(Color.white)
              .frame(height: 42)

            Text("우리 가족만의 공간이 생성되었어요.")
              .font(.custom("Pretendard-Medium", size: 20))
              .foregroundColor(Color.white.opacity(0.5))
              .padding(.top, 8)
              .frame(height: 30)
          }
        }
        
        Button(action: {

        }){
          Image("linkBtn")
        }
        .padding(.top, 70)
        
        Spacer()
        Button(action: {
//          self.showFamilyRegister = true
        }){
          Image("goRoomBtn")
        }
//        .fullScreenCover(isPresented: $showFamilyRegister, content: RegisterFamilyView.init)
        .padding(.bottom, 88-34)
        
        
        
      }
    }
}

struct RegisterFamilyFinishView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFamilyFinishView()
    }
}
