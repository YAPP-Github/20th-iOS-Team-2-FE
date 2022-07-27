//
//  SettingsView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct SettingsView: View {
  
  @State var FamilyButtonClick: Bool = false
  @State var ProfileButtonClick: Bool = false
  
  @State var familyHymn: String = "밥은 잘 챙겨먹자!"
  @State var profileNickName: String = "세상에서 가장 이쁜 딸"
  @State var profileEmail: String = "startmim98@gmail.com"
  @State var profileRoleColor: String = "#F1F8E9"
  @State var profileRoleName: String = "딸"
  @State var profileName: String = "이병기"
  @State var profileBirthDay: String = "1990-01-01"
  @ObservedObject var tabbarManager = TabBarManager.shared
  @State var currentSelectedTab: Tab = .setting // 현재 선택된 탭으로 표시할 곳
  
  var body: some View {
    NavigationView {
      ZStack{
        Color(hex: "FAF8F0").ignoresSafeArea()
        VStack(spacing: 0){
          Rectangle()
            .frame(height: 1.0, alignment: .bottom)
            .foregroundColor(Color(hex: "EDEADF"))
          
          //가족 공간 설정
          ZStack{
            Rectangle()
              .frame(width: Screen.maxWidth, height: 85)
              .foregroundColor(Color.white)
            
            VStack(spacing: 0){
              HStack{
                //가족 공간 - 이름
                Text("우리가족 공간")
                  .font(.custom("Pretendard-Bold", size: 20))
                  .foregroundColor(Color(hex: "#121619"))
                  .frame(width: 109, height: 30)
                  .padding(.leading, 16)
                Spacer()
                
                //가족 공간 - 버튼
                Button(action: {
                  FamilyButtonClick = true
                }, label: {
                  Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .medium))
                    .frame(width: 15, height: 20, alignment: .center)
                    .foregroundColor(Color.black.opacity(0.4))
                })
                .padding(.trailing, 20.5)
              }
              
              HStack{
                //가족 공간 - 가훈
                Text(familyHymn)
                  .font(.custom("Pretendard-Medium", size: 13))
                  .foregroundColor(Color.black.opacity(0.4))
                  .frame(width: 89, height: 20)
                  .padding(.leading, 16)
                  .padding(.top, 4)
                Spacer()
              }///HStack
            }
          }.padding(.top, 8)///ZStack
          Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.black.opacity(0.05))
          
          //---------------------------------
          ZStack{
            Rectangle()
              .frame(width: Screen.maxWidth, height: 79)
              .foregroundColor(Color.white)
            
            HStack(spacing: 0){
              //프로필 - 사진
              ZStack{
                Rectangle()
                  .frame(width: 48, height: 48)
                  .cornerRadius(9)
                  .foregroundColor(Color.black.opacity(0.2))
                  .padding(.leading, 16)
                
                Image(systemName: "person.fill")
                  .frame(width: 48, height: 48)
                  .cornerRadius(9)
                  .padding(.leading, 16)
                
              }
              
              VStack(spacing: 0){
                //프로필 - 별명
                HStack(spacing: 0){
                  Text(profileNickName)
                    .font(.custom("Pretendard-Medium", size: 13))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#121619"))
                    .frame(height: 20)
                    .padding(.top, 16)
                  
                  //프로필 - 뱃지
                  Rectangle()
                    .frame(width: 27, height: 20)
                    .cornerRadius(4)
                    .foregroundColor(Color(hex: profileRoleColor))
                    .overlay(
                      Text(profileRoleName)
                        .font(.custom("Pretendard-Bold", size: 12))
                        .foregroundColor(Color(hex:"#558B2F"))
                        .frame(width: 11, height: 18)
                    )
                    .padding(.top, 16)
                    .padding(.leading, 8)
                  
                  
                  Spacer()
                }
                
                //프로필 - 이메일
                HStack(spacing: 0){
                  Text(profileEmail)
                    .font(.custom("Pretendard-Medium", size: 13))
                    .foregroundColor(Color.black.opacity(0.4))
                    .frame(height: 20)
                    .padding(.top, 2)
                  Spacer()
                }
                Spacer()
              }.padding(.leading, 16)///VStack
                .frame(height: 80)
              
              Spacer()
              
              //프로필 - 버튼
              Button(action: {
                ProfileButtonClick = true
              }, label: {
                Image(systemName: "chevron.right")
                  .font(.system(size: 20, weight: .medium))
                  .frame(width: 15, height: 20, alignment: .center)
                  .foregroundColor(Color.black.opacity(0.4))
              })
              .padding(.trailing, 20.5)
              .padding(.bottom, 8)
            }///HStack
          }///ZStack
          Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.black.opacity(0.05))
          
          //---------------------------------
          ZStack{
            Rectangle()
              .frame(width: Screen.maxWidth, height: 48*5+12)
              .foregroundColor(Color.white)
            
            VStack(spacing: 0) {
              NavigationLink(destination: InviteFamilyView()){
                SettingRow(isButtonClick: .constant(true), buttonName: "person.fill.badge.plus", title: "가족 초대")
              }
              NavigationLink(destination: SetNotificationView()) {
                SettingRow(isButtonClick: .constant(true), buttonName: "bell.fill", title: "알림")
              }
              NavigationLink(destination: AccountAndSecurityView()) {
                SettingRow(isButtonClick: .constant(true), buttonName: "shield.lefthalf.filled", title: "계정 및 보안")
              }
              SettingRow(isButtonClick: .constant(true), buttonName: "mic", title: "공지")
              SettingRow(isButtonClick: .constant(true), buttonName: "star.fill", title: "소파리뷰", isLast: true)
            }///VStack
            .frame(width: Screen.maxWidth, height: 48*5, alignment: .center)
          }.padding(.top, 8)///ZStack
          Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.black.opacity(0.05))
          Spacer()
          
          if (!tabbarManager.showTabBar){
            // TabBar Show를 위한 Rectangle()
            //            Rectangle()
            //              .foregroundColor(Color.clear)
            //              .frame(height: UIDevice().hasNotch ? Screen.maxHeight * 0.11: Screen.maxHeight * 0.11 - 5)
            // Custom Tab View
            CustomTabView(selection: $currentSelectedTab)
            
            
          }
        }///VStack
        .edgesIgnoringSafeArea([.bottom])
        .navigationBarWithIconButtonStyle(isButtonClick: .constant(false), buttonColor: Color.clear, "설정", "")
        .onAppear{
          tabbarManager.showTabBar = true
        }
        
        if ProfileButtonClick {
          NavigationLink("", destination: ProfileSettingView(profileImage: "", nickName: "세상에서 가장 이쁜 딸", name: "이병기", roleName: "딸", birthDay: "1990-01-01"), isActive: $ProfileButtonClick)
        }
      }///ZStack
    }///NavigationView
    .accentColor(Color(hex: "43A047"))
  }
}


struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(familyHymn: "밥은 잘 챙겨먹자!", profileNickName: "세상에서 가장 이쁜 딸", profileRoleColor: "#F1F8E9", profileRoleName: "딸", profileName: "이병기", profileBirthDay: "1990-01-01")
  }
}
