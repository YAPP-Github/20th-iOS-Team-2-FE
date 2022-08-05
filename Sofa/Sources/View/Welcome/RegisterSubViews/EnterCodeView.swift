//
//  EnterCodeView.swift
//  Sofa
//
//  Created by 임주민 on 2022/08/04.
//

import SwiftUI
import MbSwiftUIFirstResponder

struct EnterCodeView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @State var code = ""
  @State var showContentView = false
  
  var body: some View {
    ZStack{
      Color(hex: "#009688").ignoresSafeArea()
        .padding(.bottom, 700)
      VStack(spacing: 0){
        HStack(spacing: 0){
          Image(systemName: "chevron.left")
            .font(.system(size: 20))
            .foregroundColor(.white)
            .padding(.leading, 24)
            .contentShape(Rectangle())
            .onTapGesture {
              self.presentationMode.wrappedValue.dismiss()
            }
          Text("이전")
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(.white)
            .padding(.leading, 4)
          Spacer()
        }
        ZStack{
          Rectangle()
            .ignoresSafeArea()
            .frame(height: 263-50)
            .foregroundColor(Color(hex: "#009688"))
          VStack(spacing: 0){
            Text("초대 코드 입력")
              .font(.custom("Pretendard-Bold", size: 28))
              .foregroundColor(Color.white)
              .frame(height: 42)
              .padding(.top, 13)
            Text("공간을 생성한 가족에게")
              .font(.custom("Pretendard-Medium", size: 20))
              .foregroundColor(Color.white.opacity(0.5))
              .padding(.top, 13)
              .frame(alignment: .center)
            Text("초대 코드를 받아 아래에 입력하세요.")
              .font(.custom("Pretendard-Medium", size: 20))
              .foregroundColor(Color.white.opacity(0.5))
              .padding(.top, 8)
              .frame(alignment: .center)
          }
        }
        ZStack{
          Rectangle()
            .cornerRadius(8)
            .overlay( // cornerRadius값이 있는 border 주기 위해
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "EDEADF"), lineWidth: 1)
            )
            .frame(height: 79)
            .foregroundColor(Color.white)
            .padding(.horizontal, 16)
            .padding(.top, 16)
          VStack(spacing: 0){
            ZStack{
              Rectangle()
                .frame(height: 47)
                .cornerRadius(6)
                .foregroundColor(Color(hex: "#FAF8F0"))
                .padding(.horizontal, 32)
                .padding(.top, 16)
              HStack{
                TextField("qlzpdl", text: $code)
                  .foregroundColor(Color.black.opacity(0.7))
                  .font(.custom("Pretendard-Medium", size: 18))
                  .padding(.horizontal, 44)
                  .padding(.top, 16)
                Spacer()
              }
            }
          }
        }
        Spacer()
        Button(action: {
          self.showContentView = true
        }){
          Image("goRoomBtn")
            .padding(.bottom, 88-34)
        }
        .fullScreenCover(isPresented: $showContentView) {
          ContentView()
        }
      }
    }
  }
}

struct EnterCodeView_Previews: PreviewProvider {
  static var previews: some View {
    EnterCodeView()
  }
}
