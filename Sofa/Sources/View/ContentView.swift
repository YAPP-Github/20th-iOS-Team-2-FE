//
//  ContentView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/04.
//

import SwiftUI
import SwiftKeychainWrapper

class TabBarManager: ObservableObject {
    @Published var showTabBar: Bool = true

  static let shared = TabBarManager()
}


enum Tab{
  case home
  case calendar
  case album
  case setting
}

struct ContentView: View {
  @State private var selection: Tab = .home
  @ObservedObject var tabbarManager = TabBarManager.shared
  

  var body: some View {
    VStack(spacing: 0){
      ZStack{
        switch selection {
        case .home:
          HomeView(selectionType: $selection)
        case .calendar:
          CalendarView()
        case .album:
          AlbumView()
        case .setting:
          SettingsView()
        default:
          HomeView(selectionType: $selection)
        }
      }
            
      if (tabbarManager.showTabBar){
        ZStack{
          HStack(alignment: .center){
            ForEach(0..<4) { i in
              Spacer()
                .frame(width: Screen.maxWidth * 0.05)
              Button {
                switch i{
                case 0:
                  selection = .home
                case 1:
                  selection = .calendar
                case 2:
                  selection = .album
                case 3:
                  selection = .setting
                default:
                  selection = .home
                }
              } label: {
                switch i{
                case 0:
                  VStack{
                    Image(systemName: selection == .home ? "hand.wave.fill" : "hand.wave")
                      .font(.system(size: selection == .home ? 24 : 24 ))
                      .padding(.vertical, 10)
                      .foregroundColor(selection == .home ? Color(hex: "43A047") : Color.gray)
                    Spacer()
                  }

                case 1:
                  VStack{
                    Image(systemName: "calendar")
                      .font(.system(size: 24))
                      .padding(.vertical, 10)
                      .foregroundColor(selection == .calendar ? Color(hex: "43A047") : Color.gray)
                    Spacer()
                  }
                case 2:
                  VStack{
                    Image(systemName: selection == .album ? "book.closed.fill" : "book.closed")
                      .font(.system(size: 24))
                      .padding(.vertical, 8.5)
                      .foregroundColor(selection == .album ? Color(hex: "43A047") : Color.gray)
                    Spacer()
                  }
                case 3:
                  VStack{
                    Image(systemName: "ellipsis")
                      .font(.system(size: 24))
                      .padding(.vertical, 17)
                      .foregroundColor(selection == .setting ? Color(hex: "43A047") : Color.gray)
                    Spacer()
                  }
                default:
                  Image(systemName: "ellipsis")
                    .font(.system(size: 24))
                    .foregroundColor(selection == .album ? Color(hex: "43A047") : Color.gray)
                }
              }
              
              Spacer()
                .frame(width: Screen.maxWidth * 0.05)
            } //HStack
            .frame(height: UIDevice().hasNotch ? Screen.maxHeight * 0.11 : Screen.maxHeight * 0.11 - 5)
            .ignoresSafeArea(.keyboard)
            .edgesIgnoringSafeArea(.all)
            
          }// ZStack
          .frame(width: Screen.maxWidth)
          .background(Color.white)
        }
//        .transition(.asymmetric(insertion: AnyTransition.move(edge: .bottom),                                removal: AnyTransition.move(edge: .leading)))
//        .animation(.easeIn) // Tabbar show animation
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea([.bottom])
      }
    }
    .ignoresSafeArea(.keyboard)
    .edgesIgnoringSafeArea(.all)
    .background(Color.clear)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(tabbarManager: TabBarManager())
  }
}
