//
//  AlbumView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/04.
//

import SwiftUI

struct AlbumView: View {
  @StateObject var viewModel = AlbumListViewModel()
  @ObservedObject var tabbarManager = TabBarManager.shared
  @ObservedObject var authorizationViewModel = AuthorizationViewModel()
  @State var currentSelectedTab: Tab = .album // 현재 선택된 탭으로 표시할 곳
  @State var showingSheet = false
  @State var selected = 0
  @State var showCameraSelectDate = false // 카메라 이미지 선택 -> 날짜 선택
  @State var cameraImage = UIImage() // 카메라를 통해 받아오는 이미지
  
  var actionSheetView: some View {
    ActionSheetCard(
      isShowing: $showingSheet,
      items: [
        ActionSheetCardItem(systemIconName: "photo", label: "사진") {
          showingSheet = false
          authorizationViewModel.showPhotoAlbum() // 권한 확인
        },
        ActionSheetCardItem(systemIconName: "camera", label: "카메라") {
          showingSheet = false
          authorizationViewModel.showCameraPicker() // 권한 확인
        },
        ActionSheetCardItem(systemIconName: "waveform", label: "녹음") {
          showingSheet = false
          authorizationViewModel.showAudioRecord() // 권한 확인
        }
      ]
    )
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 3) {
          Divider()
          VStack(spacing: 0) {
            Picker(selection: $selected, label: Text(""), content: {
              Text("날짜별").font(.custom("Pretendard-Regular", size: 16)).tag(0)
              Text("유형별").font(.custom("Pretendard-Regular", size: 16)).tag(1)
            })
            .padding(16)
            .background(Color.init(hex: "#FAF8F0")) //
            .pickerStyle(SegmentedPickerStyle())
            .scaleEffect(CGSize(width: 1, height: 1.1))
            
            AlbumList(viewModel: viewModel, selectType: selected) // select값에 따른 날짜별, 유형별 View
            
            if (!tabbarManager.showTabBar){
              CustomTabView(selection: $currentSelectedTab)
            }
            
            // 카메라 날짜 선택 View로 이동
            if showCameraSelectDate {
              NavigationLink("", destination: AlbumSelectDateView(title: "사진 올리기", isCameraCancle: $authorizationViewModel.showCamera, images: [cameraImage], colorScheme: .constant(ColorScheme.light)), isActive: $showCameraSelectDate)
            }
          }
          .background(Color.init(hex: "#FAF8F0")) // 임시
          .navigationBarWithIconButtonStyle(isButtonClick: $showingSheet, buttonColor: Color.init(hex: "#43A047"), "앨범", "plus") // 임시 컬러
          .fullScreenCover(isPresented: $authorizationViewModel.showAlbum) {
            // 사진 추가 View로 이동
            AlbumPhotoAddView()
              .onDisappear { viewModel.refreshActionSubject.send() }
          }
          .fullScreenCover(isPresented: $authorizationViewModel.showCamera) {
            // 카메라 imagePicker로 이동
            CameraImagePicker(selectedImage: $cameraImage, isNext: $showCameraSelectDate)
              .onDisappear { viewModel.refreshActionSubject.send() }
              .ignoresSafeArea()
          }
          .fullScreenCover(isPresented: $authorizationViewModel.showRecord) {
            // 녹음 추가 View로 이동
            AlbumRecordAddView()
              .onDisappear { viewModel.refreshActionSubject.send() }
          }
          .alert(isPresented: $authorizationViewModel.showErrorAlert) {
            // 허용안함, 카메라없는 error
            Alert(
              title: Text(authorizationViewModel.showErrorAlertTitle),
              message: Text(authorizationViewModel.showErrorAlertMessage),
              primaryButton: .default(Text("설정")) { // 앱 설정으로 이동
                if let appSettring = URL(string: UIApplication.openSettingsURLString) {
                  UIApplication.shared.open(appSettring, options: [:], completionHandler: nil)
                }
                self.tabbarManager.showTabBar = true
              },
              secondaryButton: .default(Text("확인")) {
                self.tabbarManager.showTabBar = true
              })
          }
          .edgesIgnoringSafeArea([.bottom])
        }
      } // .navigationViewStyle(StackNavigationViewStyle())
      if showingSheet { // action sheet
        Color.black
          .opacity(0.7)
          .ignoresSafeArea()
          .onTapGesture {
            showingSheet = false
            tabbarManager.showTabBar = true
          }
          .onAppear { self.tabbarManager.showTabBar = false }
        
        actionSheetView // 바텀 Sheet
      } // Zstack
    }
  }
}

struct AlbumView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumView()
  }
}
