//
//  AccountAndSecurityView.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/25.
//

import SwiftUI
import SwiftKeychainWrapper

struct AccountAndSecurityView: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var showingAlert = false
  @State var title = "계정 및 보안"
  let titles = ["개인정보 이용 약관", "서비스 이용 약관", "로그아웃", "계정 삭제"]
  @ObservedObject var tabbarManager = TabBarManager.shared
  @Binding var islogout: Bool
  var body: some View {
    ZStack{
      NavigationView{
        ZStack{
          VStack(spacing: 0){
            Border()
            Spacer()
              .frame(height: 8)
            VStack(spacing: 0){
              ForEach(titles.indices) { idx in
                switch idx{
                case 0:
                  NavigationLink {
                    Text("개인정보 이용 약관")
                  } label: {
                    settingSubRowView(titles[idx], idx)
                  }
                case 1:
                  NavigationLink {
                    Text("서비스 이용 약관")
                  } label: {
                    settingSubRowView(titles[idx], idx)
                  }
                case 2:
                  settingSubRowView(titles[idx], idx)
                    .onTapGesture {
                      showingAlert = true
                    }
                    .alert(isPresented: $showingAlert) {
                      Alert(title: Text("로그아웃"), message: Text("로그아웃 하시겠습니까?"),     primaryButton: .cancel(Text("취소"), action: {
                        
                      }),
                            secondaryButton: .default(Text("로그아웃"), action: {
                        print("로그아웃")
                        Constant.accessToken = nil
                        KeychainWrapper.standard.remove(forKey: "accessToken")
                        islogout = true
                        presentationMode.wrappedValue.dismiss()
                      }))
                      
                    }
                case 3:
                  NavigationLink {
                    RevokeAccountView()
                  } label: {
                    settingSubRowView(titles[idx], idx)
                  }
                default:
                  Text("")
                }
                
              }
              
              Rectangle()
                .foregroundColor(Color(hex: "EDEADF"))
                .frame(height: 1)
            }// VStack
            .background(Color.white)
            Spacer()
          }// VStack
          .background(Color(hex: "#FAF8F0"))
          .onAppear{
            tabbarManager.showTabBar = false
          }
          .edgesIgnoringSafeArea([.bottom])
        }//ZStack
        .navigationBarWithTextButtonStyle(isNextClick: .constant(false), isTitleClick: .constant(false), isDisalbeNextButton: .constant(false), isDisalbeTitleButton: .constant(false), title, nextText: "", Color.init(hex: "#43A047"))
      }//NavigationView
      .navigationBarHidden(true)
    }//ZStack
    
  }
  
  func settingSubRowView(_ title: String, _ idx: Int) -> some View {
    VStack(spacing: 0){
      VStack(alignment: .center, spacing: 0){
        HStack(alignment: .center, spacing: 0){
          
          //글자
          Text(title)
            .font(.custom("Pretendard-Medium", size: 16))
            .foregroundColor(Color(hex: "#121619"))
            .padding(.leading, 16)
          
          
          Spacer()
          
          //버튼
          Image(systemName: "chevron.right")
            .font(.system(size: 20, weight: .medium))
            .frame(width: 15, height: 20, alignment: .center)
            .foregroundColor(Color.black.opacity(0.4))
            .padding(.trailing, 20.5)
          
        }// HStack
        .frame(height: 48)
      }// VStack
      .background(Color.white)
      .frame(height: 48)
      if idx != 3{
        Rectangle()
          .foregroundColor(Color.black)
          .opacity(0.05)
          .frame(height: 0.5)
          .padding(.horizontal, 16)
      }
    }//VStack
  }
}

//struct AccountAndSecurityView_Previews: PreviewProvider {
//  static var previews: some View {
//    AccountAndSecurityView()
//  }
//}

struct FlatLinkStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
  }
}
