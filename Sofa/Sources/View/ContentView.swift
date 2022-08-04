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
  @State var dateToShow: String = getTodayDate()
  @ObservedObject var tabbarManager = TabBarManager.shared
  @StateObject var taskStore = TaskStore()

  var body: some View {
    VStack(spacing: 0){
      ZStack{
        switch selection {
        case .home:
          HomeView(selectionType: $selection, dateToShow: $dateToShow)
        case .calendar:
          CalendarView(currentDate: dateToShow.toDateDay()!).environmentObject(taskStore)
        case .album:
          AlbumView()
        case .setting:
          SettingsView()
        default:
          HomeView(selectionType: $selection, dateToShow: $dateToShow)
        }
      }
            
      if (tabbarManager.showTabBar){
        CustomTabView(selection: $selection)
      }
    }
    .background(Color(hex: "F9F7EF"))
//    .background(Color.red)
    .ignoresSafeArea(.keyboard)
    .edgesIgnoringSafeArea(.all)
    

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(tabbarManager: TabBarManager())
  }
}
