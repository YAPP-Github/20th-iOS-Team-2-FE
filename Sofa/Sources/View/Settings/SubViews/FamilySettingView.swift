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
  
    var body: some View {
      NavigationView {
        ZStack{
          
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

struct FamilySettingView_Previews: PreviewProvider {
    static var previews: some View {
        FamilySettingView()
    }
}
