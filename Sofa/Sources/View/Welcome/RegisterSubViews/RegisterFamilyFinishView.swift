//
//  RegisterFamilyFinishView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/13.
//

import SwiftUI

struct RegisterFamilyFinishView: View {
  
  @State var showContentView: Bool = false
  
  var body: some View {
    ZStack{
      Color(hex: "FAF8F0").ignoresSafeArea(.all)
      
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
        ZStack{
          Rectangle()
            .frame(height: 131)
            .foregroundColor(Color.white)
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .cornerRadius(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "EDEADF"), lineWidth: 1)
            )
          VStack(spacing: 0){
            ZStack{
              Rectangle()
                .frame(height: 47)
                .cornerRadius(8)
                .foregroundColor(Color(hex: "#FAF8F0"))
                .padding(.horizontal, 32)
                .padding(.top, 16)
              HStack{
                Text("vcdzu")
                  .foregroundColor(Color.black.opacity(0.5))
                  .font(.custom("Pretendard-Medium", size: 18))
                  .padding(.horizontal, 44)
                  .padding(.top, 16)
                Spacer()
              }
            }
            Button {
              print("copy")
            } label: {
              HStack{
                Image(systemName: "link")
                Text("링크 복사")
              }
              .frame(width: 326, height: 48, alignment: .center)
              .background(Color(hex: "FFB300"))
              .cornerRadius(8)
              .foregroundColor(Color.white)
            }
            .padding(.top, 4)
          }
        }
        Spacer()
        Button(action: {
          self.showContentView = true
        }){
          Image("goRoomBtn")
        }
        .fullScreenCover(isPresented: $showContentView, content: ContentView.init)
        .padding(.bottom, 88-34)
      }
    }
  }
}

struct RegisterFamilyFinishView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterFamilyFinishView()
  }
}
