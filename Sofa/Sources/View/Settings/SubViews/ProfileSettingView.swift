//
//  ProfileSettingView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/16.
//

import SwiftUI

struct ProfileSettingView: View {
  
  @Environment(\.presentationMode) var presentable
  @ObservedObject var tabbarManager = TabBarManager.shared
  
  @State var isChangeProfile: Bool = false
  @State var isDisableNextButton: Bool = false
  @State var showingSheet: Bool = false
  @State var isFocused = [false, false, false, false]
  
  @State var profileImage: String
  @State var nickName: String
  @State var name: String
  @State var roleName: String
  @State var birthDay: String
  
  var body: some View {
    ZStack{
      NavigationView {
        ZStack{
          //기본 배경
          Color(hex: "FAF8F0").ignoresSafeArea()
          ScrollView{
            VStack(spacing: 0) {
              ZStack{
                VStack(spacing: 0){
                  //초록 배경
                  Image("profileFrame")
                    .resizable()
                    .frame(width: Screen.maxWidth)
                  //흰 배경
                  Rectangle()
                    .frame(width: Screen.maxWidth, height: 40)
                    .foregroundColor(Color.white)
                  Border().padding(.bottom, 8)
                }
                
                // 프로필 사진
                ZStack {
                  Rectangle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color.gray)
                    .cornerRadius(9)
                  Image(profileImage)
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(9)
                    .clipped()
                    .overlay(RoundedRectangle(cornerRadius: 9)
                      .stroke(Color.white, lineWidth: 2))
                }
              }
              
              //입력창
              ZStack{
                Color.white.frame(height: 420)
                VStack(spacing: 0){
                  
                  //입력창 - 별명
                  profileText(text: "별명")
                  profileTextField(text: $nickName, isFocused: $isFocused[0], showingSheet: $showingSheet)
                    .frame(height: 48)
                    .padding(.bottom, 32)
                    .padding(.horizontal, 16)
                  
                  //입력창 - 성함
                  profileText(text: "성함")
                  profileTextField(text: $name, isFocused: $isFocused[1], showingSheet: $showingSheet)
                    .frame(height: 48)
                    .padding(.bottom, 32)
                    .padding(.horizontal, 16)
                                    
                  //입력창 - 역할
                  profileText(text: "역할")
                  profileTextField(text: $roleName, isFocused: $isFocused[2], showingSheet: $showingSheet, isRoleName: true)
                    .frame(height: 48)
                    .padding(.bottom, 32)
                    .padding(.horizontal, 16)
                  
                  //입력창 - 생년월일
                  profileText(text: "생년월일")
                  profileTextField(text: $birthDay, isFocused: $isFocused[3], showingSheet: $showingSheet, isBirthDay: true)
                    .frame(height: 48)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                  
                  Spacer()
                }.padding(.top, 30)
                
              }.frame(height: 420)
              
              Border()
              
              //스크롤 여백 공간
              Rectangle()
                .frame(height: 300)
                .foregroundColor(Color.clear)
              
              Spacer()
            }///VStack
            
          }.frame(height: 420)
          
          //스크롤 여백 공간
          Rectangle()
            .frame(height: 300)
            .foregroundColor(Color.clear)
          
          Spacer()
        }///VStack
        
      }///ScrollView
      .navigationBarWithTextButtonStyle(isNextClick: $isChangeProfile, isTitleClick: .constant(false), isDisalbeNextButton: $isDisableNextButton, isDisalbeTitleButton: .constant(false), "프로필", nextText: "수정", Color.init(hex: "#43A047"))
          }///ScrollView
        }///ZStack
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
        .navigationTitle("프로필")
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
      }///NavigationView
      .navigationViewStyle(StackNavigationViewStyle())
      .navigationBarHidden(true)
      actionSheetView
    }///ZStack
  }///body
  
  var actionSheetView: some View {
    RoleActionSheet(
      isShowing: $showingSheet,
      items: [
        RoleActionSheetItem(label: "아빠") {
          showingSheet = false
          roleName = "아빠"
        },
        RoleActionSheetItem(label: "엄마") {
          showingSheet = false
          roleName = "엄마"
        },
        RoleActionSheetItem(label: "할아버지") {
          showingSheet = false
          roleName = "할아버지"
        },
        RoleActionSheetItem(label: "할머니") {
          showingSheet = false
          roleName = "할머니"
        },
        RoleActionSheetItem(label: "아들") {
          showingSheet = false
          roleName = "아들"
        },
        RoleActionSheetItem(label: "딸") {
          showingSheet = false
          roleName = "딸"
        },
        RoleActionSheetItem(label: "사위") {
          showingSheet = false
          roleName = "사위"
        },
        RoleActionSheetItem(label: "며느리") {
          showingSheet = false
          roleName = "며느리"
        }
      ],
      outOfFocusOpacity: 0.2,
      itemsSpacing: 0
    )
    .onDisappear {
      UITabBar.showTabBar()
    }
    
  }///actionSheetView
  
}///struct


struct profileText: View { //별명, 성함 등..
  var text: String
  var body: some View {
    HStack{
      Text(text)
        .font(.custom("Pretendard-Medium", size: 14))
        .foregroundColor(Color(hex: "#121619"))
      Spacer()
    } .frame(height: 21)
      .padding(.leading, 20)
      .padding(.bottom, 4)
      .edgesIgnoringSafeArea(.bottom)
  }
}

struct profileTextField: View { //텍스트필드
  @Binding var text: String
  @Binding var isFocused: Bool
  @Binding var showingSheet: Bool
  var isRoleName: Bool = false
  var isBirthDay: Bool = false
  
  var body: some View {
    ZStack{
      TextField("", text: $text)
        .disabled(isRoleName)
        .customTextField(padding: 12)
        .disableAutocorrection(true)
        .background(isFocused ? Color.white : Color(hex: "FAF8F0"))
        .cornerRadius(6)
        .edgesIgnoringSafeArea(.bottom)
        .highlightTextField(firstLineWidth: isFocused || (showingSheet&&isRoleName) ? 1 : 0, secondLineWidth: isFocused || (showingSheet&&isRoleName) ? 4 : 0)
        .onAppear {
          UIApplication.shared.hideKeyboard()
        }
      
      UITextFieldRepresentable(
        text: $text,
        isFirstResponder: false,
        isNumberPad: isBirthDay, isFocused: $isFocused
      ).disabled(isRoleName).padding(.horizontal, 17)
      
      if isRoleName {
        HStack{
          Spacer()
          Image(systemName: "chevron.down")
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(Color(hex: "#121619"))
            .padding(.trailing, 12.5)
            .contentShape(Rectangle())
            .edgesIgnoringSafeArea(.bottom)
            .onTapGesture {
              self.showingSheet = true
            }
        }
      }
    }
  }
}

struct ProfileSettingView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileSettingView(profileImage: "", nickName: "세상에서 가장 이쁜 딸", name: "이병기", roleName: "딸", birthDay: "1990-01-01")
  }
}
