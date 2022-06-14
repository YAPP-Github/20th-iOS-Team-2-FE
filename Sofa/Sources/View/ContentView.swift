//
//  ContentView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/04.
//

import SwiftUI

struct ContentView: View {
  @State private var selection: Tab = .home
  
  enum Tab {
    case home
    case calendar
    case album
    case setting
  }
  
  var body: some View {
    TabView(selection: $selection) {
      HomeView()
        .tabItem {
          Image(systemName: "person.3.fill")
          Text("홈")
        }
        .tag(Tab.home)
      CalendarView()
        .tabItem {
          Image(systemName: "calendar")
          Text("캘린더")
        }
        .tag(Tab.calendar)
      AlbumView()
        .tabItem {
          Image(systemName: "book.closed")
          Text("앨범")
        }
        .tag(Tab.album)
      SettingsView()
        .tabItem {
          Image(systemName: "gearshape.fill")
          Text("설정")
        }
        .tag(Tab.setting)
    }
    .accentColor(.black)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
