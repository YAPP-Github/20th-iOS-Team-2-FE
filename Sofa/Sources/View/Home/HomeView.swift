//
//  HomeView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct HomeView: View {
  
  @StateObject var eventViewModel = EventViewModel()
  @State var gotoAlarm = false
  @State var showModal = false
  @State var showMessageView = false
  @Binding var selectionType: Tab
  @Binding var dateToShow: String
  @State var text: String?
  @State var placeholder = "가족에게 인사를 남겨보세요."
  @State var currentSelectedTab: Tab = .home // 현재 선택된 탭으로 표시할 곳
  
  @ObservedObject var tabbarManager = TabBarManager.shared
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 0){ // Custom Navigation View
          HStack{
            Text("\(eventViewModel.hometitle)")
              .font(.custom("Pretendard-Bold", size: 24))
            Spacer()
            NavigationLink(destination: NotificationView(selectionType: $selectionType).onAppear{tabbarManager.showTabBar = false}){
              Image(systemName: "bell")
                .resizable()
                .foregroundColor(Color.black)
                .frame(width: 20, height: 20)
                .overlay(
                  Circle()
                    .foregroundColor(Color(hex: "EC407A"))
                    .frame(width: 8, height: 8)
                    .offset(x: 5, y: -5)
                )
            }
            .offset(x: 40, y: 0)
          }
          .padding(EdgeInsets(top: 7, leading: 24, bottom: 12, trailing: 68))
          .background(Color.white)
          .frame(height: 44)
          ScrollView{
            VStack{
              EventList(eventViewModel: eventViewModel, page: .first(), alignment: .start, selectionType: $selectionType, dateToShow: $dateToShow)
                .frame(height: eventViewModel.events.count == 0 ? 0 : 64)
                .padding(.vertical, eventViewModel.events.count == 0 ? 0 : 16)
                .animation(.default)
            }
            .overlay(Rectangle().frame(width: nil, height: eventViewModel.events.count == 0 ? 0 : 1, alignment: .top).foregroundColor(Color(hex: "EDEADF")), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: eventViewModel.events.count == 0 ? 0 : 1, alignment: .bottom).foregroundColor(Color(hex: "EDEADF")), alignment: .bottom)
            .background(Color(hex: "F5F2E9"))
            ChatList(showModal: $showModal)
              .fullScreenCover(isPresented: $showModal) {
                HistoryView(isShowing: $showModal)
                  .background(BackgroundCleanerView())
//                  .onAppear{
//                    tabbarManager.showTabBar = false
//                  }
//                  .onDisappear{
//                    tabbarManager.showTabBar = true
//                  }
              }
          }// ScrollView
          .background(Color(hex: "F9F7EF"))
          EmojiView(messageShow: $showMessageView)
            .frame(height: showMessageView ? 0 : 52, alignment: .center)
            .offset(x: 0, y: -24)
            .padding(.horizontal, 23)
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: $showMessageView) {
              MessageView($showMessageView, $text, $placeholder)
                .background(BackgroundCleanerView())
            }
          
          
//          if (!tabbarManager.showTabBar){
//            // TabBar Show를 위한 Rectangle()
////            Rectangle()
////              .foregroundColor(Color.clear)
////              .frame(height: UIDevice().hasNotch ? Screen.maxHeight * 0.11: Screen.maxHeight * 0.11 - 5)
//            // Custom Tab View
//            CustomTabView(selection: $currentSelectedTab)
//
//
//          }
          
        }// VStack
        .ignoresSafeArea(.keyboard)
        .background(Color(hex: "F9F7EF"))
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.bottom])
        .onAppear{
          tabbarManager.showTabBar = true
        }
      }// NavigationView
      .navigationViewStyle(StackNavigationViewStyle())
      .accentColor(Color(hex: "43A047"))
      
      if (showModal || showMessageView){
        Color.black
          .opacity(0.7)
          .ignoresSafeArea()
      }
    }// ZStack
  }
  
}

//struct HomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    HomeView(selectionType: .constant(.home))
//  }
//}

struct BackgroundCleanerView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}
