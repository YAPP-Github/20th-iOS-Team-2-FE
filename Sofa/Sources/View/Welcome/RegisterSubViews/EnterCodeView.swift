//
//  EnterCodeView.swift
//  Sofa
//
//  Created by 임주민 on 2022/08/04.
//

import SwiftUI

struct EnterCodeView: View {
    var body: some View {
      VStack(spacing: 0){
        ZStack{
          Rectangle()
            .ignoresSafeArea()
            .frame(height: 263-34)
            .foregroundColor(Color(hex: "#009688"))
          VStack(spacing: 0){
            Text("초대 코드 입력")
              .font(.custom("Pretendard-Bold", size: 28))
              .foregroundColor(Color.white)
              .frame(height: 42)
            Text("          공간을 생성한 가족에게\n초대 코드를 받아 아래에 입력하세요.")
              .font(.custom("Pretendard-Medium", size: 20))
              .foregroundColor(Color.white.opacity(0.5))
              .padding(.top, 8)
              .frame(alignment: .center)
          }
        }
          ZStack{
            Rectangle()
              .frame(height: 47)
              .foregroundColor(Color(hex: "#FAF8F0"))
              .padding(.horizontal, 32)
              .padding(.top, 16)
            HStack{
              Text("qlzpdl_dkdleldj_2909.com")
                .foregroundColor(Color.black.opacity(0.4))
                .font(.custom("Pretendard-Medium", size: 18))
                .padding(.horizontal, 44)
                .padding(.top, 16)
              Spacer()
            }
          }
          
        Spacer()
        NavigationLink {
          ContentView()
        } label: {
          Image("goRoomBtn")
            .padding(.bottom, 88-34)
        }
      }
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
    }
}
