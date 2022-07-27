//
//  FamilySettingView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/24.
//

import SwiftUI

struct FamilySettingView: View {
  
  @Environment(\.presentationMode) var presentable
  @ObservedObject var tabbarManager = TabBarManager.shared
  
  @State var familyName: String
  @State var familyMotto: String
  @State var familyInfoFocused = [false, false]
  var familyMemberName = ["엄마", "아빠", "오빠", "언니"]
  let familyCount = 4
  
    var body: some View {
      NavigationView {
        ZStack{
          //기본 배경
          Color(hex: "FAF8F0").ignoresSafeArea()
          ScrollView{
            VStack(spacing: 0) {
              Border()
              
              ZStack{
                Color.white
                VStack(spacing: 0){
                  profileText(text: "가족공간명")
                    .padding(.top, 16)
                  profileTextField(text: $familyName, isFocused: $familyInfoFocused[0], showingSheet: .constant(false))
                  profileText(text: "가훈")
                  profileTextField(text: $familyMotto, isFocused: $familyInfoFocused[1], showingSheet: .constant(false))
                }
              }.padding(.top, 8)
              Border()
              
              ZStack{
                Color.white
                VStack(spacing: 0) {
                  HStack{
                    Text("가족 구성원")
                      .padding(.leading, 16)
                      .padding(.top, 16)
                      .font(.custom("Pretendard-Bold", size: 14))
                    Spacer()
                  }
                  ForEach(0..<familyCount) {idx in
                    FamilyMemberRow(nickName: familyMemberName[idx])
                  }
                }
              }.padding(.top, 8)
              Border()
              
            }
          }
        }
        .navigationBarItems(
          leading: Button(action: {
            presentable.wrappedValue.dismiss()
          }, label: {
            HStack(spacing: 0) {
              Image(systemName: "chevron.left")
              Text("이전")
                .font(.custom("Pretendard-Medium", size: 16))
                .fontWeight(.semibold)
            }
          })
          .accentColor(Color(hex: "#43A047"))
          .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
          trailing: Button(action: {
            // 수정 업로드
            presentable.wrappedValue.dismiss()
            tabbarManager.showTabBar = true
            UITabBar.showTabBar()
          }, label: {
            HStack(spacing: 0) {
              Text("수정")
                .font(.custom("Pretendard-Medium", size: 16))
                .fontWeight(.semibold)
            }
          })
          .accentColor(Color(hex: "#43A047"))
          .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("가족 공간")
        .onAppear {
          let appearance = UINavigationBarAppearance()
          appearance.configureWithTransparentBackground()
          appearance.backgroundColor =
          UIColor.systemBackground.withAlphaComponent(1)
          UINavigationBar.appearance().standardAppearance = appearance
          UINavigationBar.appearance().compactAppearance = appearance
          UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .edgesIgnoringSafeArea([.bottom]) // Bottom만 safeArea 무시
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .navigationBarHidden(true)
    }
}

struct Border: View {
  var body: some View {
    Rectangle()
      .frame(height: 1)
      .foregroundColor(Color(hex: "#EDEADF"))
  }
}

struct FamilyMemberRow: View {
  @State var nickName: String
  @State var isFocused = false
  
  var body: some View {
    HStack(spacing: 0){
      ZStack{
        //이미지
        RoundedRectangle(cornerRadius: 9)
          .frame(width: 56, height: 56)
          .foregroundColor(Color(hex: "#F5F2E9"))
      }
      VStack(spacing: 0){
        HStack(spacing: 0){
          //성함
          Text("성함")
            .font(.custom("Pretendard-Bold", size: 13))
            .padding(.leading, 24)
          Spacer()
          //관계
          Rectangle()
            .frame(width: 37, height: 20)
            .cornerRadius(4)
            .foregroundColor(Color(hex: "#F1F8E9"))
            .overlay(
              Text("관계")
                .font(.custom("Pretendard-Bold", size: 12))
                .foregroundColor(Color(hex:"#558B2F"))
                .frame(width: 21, height: 18)
            )
        }
        //별명
        profileTextField(text: $nickName, isFocused: $isFocused, showingSheet: .constant(false))
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
  }
}

struct FamilySettingView_Previews: PreviewProvider {
    static var previews: some View {
        FamilySettingView(familyName: "우리가족 공간", familyMotto: "밥은 잘 챙겨먹자!")
    }
}
