//
//  AlbumView.swift
//  Sofa
//
//  Created by 임주민 on 2022/06/04.
//

import SwiftUI

struct AlbumView: View {
  @State var showingSheet = false
  @State var albums = MockData().albumByDate
  @State var types = MockData().albumByType
  @State var selected = 0
  @State var showPhotoAdd = false
  @State var showRecordAdd = false
  
  var actionSheetView: some View {
    ActionSheetCard(
      isShowing: $showingSheet,
      items: [
        ActionSheetCardItem(systemIconName: "photo", label: "사진") {
          UITabBar.toogleTabBarVisibility()
          showingSheet = false
          showPhotoAdd = true
        },
        ActionSheetCardItem(systemIconName: "camera", label: "카메라") {
          UITabBar.toogleTabBarVisibility()
          showingSheet = false
        },
        ActionSheetCardItem(systemIconName: "waveform", label: "녹음") {
          UITabBar.toogleTabBarVisibility()
          showingSheet = false
          showRecordAdd = true
        }
      ],
      outOfFocusOpacity: 0.2,
      itemsSpacing: 0
    )
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 0) {
          Picker(selection: $selected, label: Text(""), content: {
            Text("날짜별").tag(0)
            Text("유형별").tag(1)
          })
          .padding()
          .background(Color.init(hex: "#FAF8F0")) // 임시
          .pickerStyle(SegmentedPickerStyle())
          
          if selected == 0 { // 날짜별
            AlbumList(albumDate: albums)
          } else if selected == 1 { // 유형별
            AlbumList(albumType: types)
          }
          
          // 임시
          // 사진 추가 View로 이동
//          NavigationLink("", destination: AlbumPhotoAddView(), isActive: $showPhotoAdd)
          
          // 녹음 추가 View로 이동
//          NavigationLink("", destination: AlbumRecordAddView(), isActive: $showRecordAdd)
        }
        .navigationBarWithIconButtonStyle(isButtonClick: $showingSheet, buttonColor: Color.init(hex: "#43A047"), "앨범", "plus") // 임시 컬러
        .fullScreenCover(isPresented: $showPhotoAdd) { // 사진 추가 View로 이동
          AlbumPhotoAddView()
        }
        .fullScreenCover(isPresented: $showRecordAdd) { // 녹음 추가 View로 이동
          AlbumRecordAddView()
        }
      }
      actionSheetView // 바텀 Sheet
    }
  }
}

struct AlbumView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumView(albums: MockData().albumByDate, types: MockData().albumByType)
  }
}
