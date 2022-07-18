//
//  AlbumView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/04.
//

import SwiftUI


struct AlbumView: View {
  @ObservedObject var authorizationViewModel = AuthorizationViewModel()
  @State var showingSheet = false
  @State var selected = 0
  @State var showCameraSelectDate = false // 카메라 이미지 선택 -> 날짜 선택
  @State var cameraImage: UIImage? // 카메라를 통해 받아오는 이미지
  
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
    .onDisappear { UITabBar.showTabBar() }
  }
  
  var body: some View {
    ZStack {
      NavigationView {
        VStack(spacing: 0) {
          Picker(selection: $selected, label: Text(""), content: {
            Text("날짜별").font(.custom("Pretendard-Regular", size: 16)).tag(0)
            Text("유형별").font(.custom("Pretendard-Regular", size: 16)).tag(1)
          })
          .padding(16)
          .background(Color.init(hex: "#FAF8F0")) // 임시
          .pickerStyle(SegmentedPickerStyle())
          
          AlbumList(selectType: selected) // select값에 따른 날짜별, 유형별 View
          
          // 카메라 날짜 선택 View로 이동
          NavigationLink("", destination: AlbumSelectDateView(title: "사진 올리기", isCameraCancle: $authorizationViewModel.showCamera, image: cameraImage), isActive: $showCameraSelectDate)
        }
        .background(Color.init(hex: "#FAF8F0")) // 임시
        .navigationBarWithIconButtonStyle(isButtonClick: $showingSheet, buttonColor: Color.init(hex: "#43A047"), "앨범", "plus") // 임시 컬러
        .fullScreenCover(isPresented: $authorizationViewModel.showAlbum) {
          // 사진 추가 View로 이동
          AlbumPhotoAddView()
        }
        .fullScreenCover(isPresented: $authorizationViewModel.showCamera) {
          // 카메라 imagePicker로 이동
          CameraImagePicker(selectedImage: $cameraImage, isNext: $showCameraSelectDate)
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $authorizationViewModel.showRecord) {
          // 녹음 추가 View로 이동
          AlbumRecordAddView()
        }
        .alert(isPresented: $authorizationViewModel.showErrorAlert) {
          // 카메라 error
          Alert(
            title: Text(authorizationViewModel.showErrorAlertTitle),
            message: Text(authorizationViewModel.showErrorAlertMessage),
            primaryButton: .default(Text("설정")) { // 앱 설정으로 이동
              if let appSettring = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettring, options: [:], completionHandler: nil)
              }
            },
            secondaryButton: .default(Text("확인")))
        }
        .onAppear { UITabBar.showTabBar() }
      }
      if showingSheet { // action sheet
        Color.black
          .opacity(0.7)
          .ignoresSafeArea()
          .onTapGesture {
            showingSheet = false
          }
        
        actionSheetView // 바텀 Sheet
      }
    }
  }
}

struct AlbumView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumView()
  }
}
