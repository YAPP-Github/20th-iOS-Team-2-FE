//
//  RevokeAccountView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/27.
//

import SwiftUI

struct RevokeAccountView: View {
  @ObservedObject var tabbarManager = TabBarManager.shared
  @State var checkButtonClicked = false
  @State var revokeButtonClicked = false
  var body: some View {
    VStack(spacing: 0){
      HStack(alignment: .center){
        Image("info.circle.fill")
          .resizable()
          .frame(width: 24, height: 24, alignment: .center)
          .padding(.leading, 16)
          .padding(.trailing, 8)
          .padding(.vertical, 16)
        Text("계정을 삭제하기 전에 꼭 확인해 주세요!")
          .font(.custom("Pretendard-Regular", size: 14))
          .foregroundColor(Color(hex: "#FF6F00"))
          .padding(.vertical, 16)
        Spacer()
      }//HStack
      .background(Color(hex: "#FFF8E1"))
      .cornerRadius(8)
      .overlay( // cornerRadius값이 있는 border 주기 위해
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color(hex: "FFECB3"), lineWidth: 1)
      )
      .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
      VStack(alignment: .leading){
        VStack(alignment: .leading, spacing: 6) {
          HStack(alignment: .top){
            Text("·").fontWeight(.black)
            Text("가족 공간 내 자료 열람이 차단됩니다.")
          }
          HStack(alignment: .top){
            Text("·").fontWeight(.black)
            Text("계정 삭제 전 필요한 자료를 다운 받는 것을 권장합니다.")
          }
          HStack(alignment: .top){
            Text("·").fontWeight(.black)
            Text("계정을 삭제하면 가족 공간내 모든 자료의 열람이 차단되며, 복구가 불가능합니다.")
          }
          HStack(alignment: .top){
            Text("·").fontWeight(.black)
            Text("같은 계정으로 다시 가입해도 이전 자료는 더 이상 복구 및 백업하실 수 없습니다.")
          }
          HStack(alignment: .top){
            Text("·").fontWeight(.black)
            Text("계정 삭제 전 신중하게 선택해 주시기 바랍니다.")
          }
        }
        .lineSpacing(5)
        .font(.custom("Pretendard-Regular", size: 14))
        .padding(16)
      }//VStack
      .background(Color(hex: "#FFFFFF"))
      .cornerRadius(8)
      .overlay( // cornerRadius값이 있는 border 주기 위해
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color(hex: "EDEADF"), lineWidth: 1)
      )
      .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
      HStack{
        Image(checkButtonClicked ? "checkmark.circle.fill" : "checkmark.circle")
          .resizable()
          .frame(width: 24, height: 24, alignment: .center)
          .padding(.leading, 16)
          .padding(.trailing, 8)
          .padding(.vertical, 16)
        Text("위 내용을 모두 확인했습니다.")
          .font(.custom("Pretendard-Regular", size: 14))
          .foregroundColor(Color(hex: "#21272A"))
          .padding(.vertical, 16)
        Spacer()
      }//HStack
      .background(Color(hex: "#FFFFFF"))
      .cornerRadius(8)
      .overlay( // cornerRadius값이 있는 border 주기 위해
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color(hex: "EDEADF"), lineWidth: 1)
      )
      .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
      .onTapGesture {
        if checkButtonClicked {
          checkButtonClicked = false
          revokeButtonClicked = false
        }else{
          checkButtonClicked = true
          revokeButtonClicked = true
        }
      }
      Spacer()
      HStack(alignment: .center){
        Spacer()
        Text("계정 삭제")
          .font(.custom("Pretendard-Regular", size: 18))
          .foregroundColor(revokeButtonClicked ? Color(hex: "FF6F00") : Color.black.opacity(0.24))
          .padding(.vertical, 12)
        Spacer()
      }//HStack
      .background(revokeButtonClicked ? Color(hex: "#FFF8E1") : Color(hex: "#EDEADF"))
      .cornerRadius(8)
      .padding(.horizontal, 16)
      .padding(.bottom, UIDevice().hasNotch ? 42 : 37)
      .onTapGesture {
        print("계정이 삭제되었습니다.")
      }
    }//VStack
    .onAppear{
      tabbarManager.showTabBar = false
    }
    .navigationTitle("계정 삭제")
    .background(Color(hex: "#FAF8F0"))
    .edgesIgnoringSafeArea([.bottom])
  }
}

struct RevokeAccountView_Previews: PreviewProvider {
  static var previews: some View {
    RevokeAccountView()
  }
}
