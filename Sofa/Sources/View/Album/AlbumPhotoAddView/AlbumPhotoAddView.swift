//
//  AlbumPhotoAddView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import SwiftUI
import Photos

struct AlbumPhotoAddView: View {
  @Environment(\.presentationMode) var presentable
  @State var isNext = false
  @State var imageClick: UIImage?
  @State var selected: [SelectedImages] = []
  
  // Toast Message
  @State var showToastMessage: Bool = false
  @State private var messageData: ToastMessage.MessageData = ToastMessage.MessageData(title: "최대 3장까지 올릴 수 있어요", type: .Warning)
  
  private let height = Screen.maxHeight * 0.425
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        VStack {
          
          if imageClick != nil { // 첫 Appear상태에는 선택된 이미지가 없음
            ZoomScrollView {
              Image(uiImage: imageClick!)
                .resizable()
                .scaledToFit()
                .frame(height: height) // 화면의 반
            }
          }
        }
        .frame(width: Screen.maxWidth, height: height) // 화면의 반
        
        AlbumPhotoAddList(selected: $selected, imageClick: $imageClick, showToastMessage: $showToastMessage, parant: self)
        
        // 날짜 선택으로 이동
        NavigationLink("", destination: AlbumSelectDateView(title: "사진 올리기", isCameraCancle: .constant(false), photoParent: self, images: selected.map{$0.image}, colorScheme: .constant(ColorScheme.light) ), isActive: $isNext)
      }
      .background(Color.black) // 배경색
      .edgesIgnoringSafeArea([.bottom]) // Bottom만 safeArea 무시
      .toastMessage(data: $messageData, isShow: $showToastMessage, topInset: 0)
      .navigationBarInlineStyle(isNextClick: $isNext, isDisalbeNextButton: .constant(selected.isEmpty), buttonColor: Color.init(hex: "#43A047"), "사진 선택") // 임시 컬러
      .onDisappear { UITabBar.showTabBar() }
    }
  }
}

struct AlbumPhotoAddView_Previews: PreviewProvider {
  static var previews: some View {
    let data = UIImage(named: MockData().photoList[0])!
    let selectedImage = SelectedImages(asset: PHAsset(), image: data)
    
    AlbumPhotoAddView(imageClick: data, selected: [selectedImage])
  }
}
