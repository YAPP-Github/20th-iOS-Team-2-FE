//
//  ContentView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/04.
//

import SwiftUI

enum Tab{
  case home
  case calendar
  case album
  case setting
}

struct ContentView: View {
  @State private var selection: Tab = .home
    
  var body: some View {
    TabView(selection: $selection) {
      HomeView(selectionType: $selection)
        .tabItem {
          Image(systemName: "hand.wave")
        }
        .tag(Tab.home)
      CalendarView()
        .tabItem {
          Image(systemName: "calendar")
        }
        .tag(Tab.calendar)
      AlbumView()
        .tabItem {
          Image(systemName: "book.closed")
        }
        .tag(Tab.album)
      SettingsView()
        .tabItem {
          Image(systemName: "ellipsis")
        }
        .tag(Tab.setting)
    }
    .accentColor(.black)
    .onAppear {
        UITabBar.appearance().backgroundColor = .white
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
