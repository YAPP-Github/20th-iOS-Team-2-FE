//
//  HomeView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var eventViewModel = EventViewModel()
  @State var gotoAlarm = false
  @State var showModal = false
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 0){ // Custom Navigation View
          HStack{
            Text("\(eventViewModel.hometitle)")
              .font(.custom("Pretendard-Bold", size: 24))
            Spacer()
            NavigationLink(destination: NotificationView()){
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
          .background(.white)
          ScrollView{
            LazyVStack{
              EventList(eventViewModel: eventViewModel, page: .first(), alignment: .start)
                .frame(height: eventViewModel.events.count == 0 ? 0 : 64)
                .padding(.vertical, eventViewModel.events.count == 0 ? 0 : 16)
            }
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color(hex: "EDEADF")), alignment: .top)
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color(hex: "EDEADF")), alignment: .bottom)
            .background(Color(hex: "F5F2E9"))
            ChatList(showModal: $showModal)
              .fullScreenCover(isPresented: $showModal) {
                ModalView(isShowing: $showModal)
                  .background(BackgroundCleanerView())
              }
          }// ScrollView
          .background(Color(hex: "F9F7EF"))
          EmojiView()
            .offset(x: 0, y: -24)
            .padding(.horizontal, 23)
        }// VStack
        .background(Color(hex: "F9F7EF"))
        .navigationBarHidden(true)
      }// NavigationView
      if showModal{
        Color.black
          .opacity(0.7)
          .ignoresSafeArea()
      }
    }// ZStack
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

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
