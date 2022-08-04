//
//  HomeView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct HomeView: View {
  @StateObject var messageVM = MessageViewModel()
  @StateObject var vm = ChatScreenViewModel()
  @StateObject var homeinfoVM = HomeInfoViewModel()
  
  @State var gotoAlarm = false
  @State var showModal = false
  @State var historyUserId = 0
  @State var showMessageView = false
  @Binding var selectionType: Tab
  @Binding var dateToShow: String
  @State var text: String?
  @State var placeholder = "가족에게 인사를 남겨보세요."
  @State var currentSelectedTab: Tab = .home // 현재 선택된 탭으로 표시할 곳
  @State var receivedText = ""
 
  
//  @StateObject var socket = StarscreamWebsocket()
  @State var emojiViewOffset = -24.0
  
  @ObservedObject var tabbarManager = TabBarManager.shared
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 0){
          ScrollView{
            VStack{
              EventList(homeinfoVM: homeinfoVM, page: .first(), alignment: .start, selectionType: $selectionType, dateToShow: $dateToShow)
                .frame(height: homeinfoVM.events.count == 0 ? 0 : 64)
                .padding(.vertical, homeinfoVM.events.count == 0 ? 0 : 16)
                .animation(.default)
            }
            .overlay(Rectangle().frame(width: nil, height: homeinfoVM.events.count == 0 ? 0 : 1, alignment: .top).foregroundColor(Color(hex: "EDEADF")), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: homeinfoVM.events.count == 0 ? 0 : 1, alignment: .bottom).foregroundColor(Color(hex: "EDEADF")), alignment: .bottom)
            .background(Color(hex: "F5F2E9"))
            ChatList(historyUserId: $historyUserId, showModal: $showModal)
              .fullScreenCover(isPresented: $showModal) {
                HistoryView($historyUserId, $showModal)
                  .background(BackgroundCleanerView())
                  .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.00000000000000001) {
                      tabbarManager.showTabBar = false
                    }
                  }
                  .onDisappear{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.00000000000000001) {
                      tabbarManager.showTabBar = true
                    }
                  }
              }
            if gotoAlarm{
              NavigationLink("", isActive: $gotoAlarm) {
                NotificationView(selectionType: $selectionType)
                  .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.00000000000000001) {
                      tabbarManager.showTabBar = false
                      emojiViewOffset = UIDevice().hasNotch ? -24 : -15
                    }

                  }
                  .onDisappear{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.00000000000000001) {
                      tabbarManager.showTabBar = true
                      emojiViewOffset = UIDevice().hasNotch ? -Screen.maxHeight * 0.11 - 24 : -Screen.maxHeight * 0.11 - 5 - 15
                    }

                  }
              }
            }
          }// ScrollView
          .background(Color(hex: "F9F7EF"))
          EmojiView(messageShow: $showMessageView)
            .frame(height: 52)
            .offset(x: 0, y: emojiViewOffset)
            .opacity(tabbarManager.showTabBar ? 1 : 0)
            .padding(.horizontal, 23)
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: $showMessageView) {
              MessageView($showMessageView, $text, 0, $placeholder) {
                if let text = text {
                  self.messageVM.postMessage(content: text)
                  self.text = nil
                }
              }
              .onDisappear{
                self.vm.receiveMessage()
              }
                .background(BackgroundCleanerView())
            }
          
          
          if (!tabbarManager.showTabBar){
            // TabBar Show를 위한 Rectangle()
//            Rectangle()
//              .foregroundColor(Color.clear)
//              .frame(height: UIDevice().hasNotch ? Screen.maxHeight * 0.11: Screen.maxHeight * 0.11 - 5)
            // Custom Tab View
            CustomTabView(selection: $currentSelectedTab)


          }

          
        }// VStack
        .ignoresSafeArea(.keyboard)
        .background(Color(hex: "F9F7EF"))
//        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.bottom])
        .homenavigationBarStyle(isButtonClick: $gotoAlarm, buttonColor: Color(hex: "121619"), $homeinfoVM.hometitle, "bell")
        .onAppear{
          tabbarManager.showTabBar = true
//          print(Constant.accessToken ?? "")
//          print(Constant.userId ?? 0)
        }
        .onAppear{
          self.vm.connect() // 웹소켓 연결
          Chat.shared.first = true
        }
      }// NavigationView
      .navigationViewStyle(StackNavigationViewStyle())
      .accentColor(Color(hex: "43A047"))
      
      if (showModal || showMessageView){
        Color.black
          .opacity(0.7)
          .ignoresSafeArea()
          .animationsDisabled()
          .onAppear{
            DispatchQueue.main.async {
              emojiViewOffset = -24
            }
          }
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
