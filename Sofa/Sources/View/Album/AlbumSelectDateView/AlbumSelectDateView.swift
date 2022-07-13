//
//  AlbumSelectDateView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import SwiftUI

struct AlbumSelectDateView: View {
  @Environment(\.presentationMode) var presentable
  @State var isNext = false
  @State var isDisalbeNextButton: Bool = false
  var title: String = "올리기"
  let buttonColor: Color = Color.init(hex: "#43A047") // 임시
  
  // 갤러리 사진들
  @State var imageList: [SelectedImages]? // 갤러리 사진들
  var photoParent: AlbumPhotoAddView?
  
  // 카메라 사진
  @Binding var isCameraCancle: Bool
  @State var image: UIImage? // 카메라 사진
  
  // 녹음
  @ObservedObject var fetcher = AudioRecorderURLViewModel()
  @State var recordTitle: String = ""
  var recordParent: AlbumRecordAddView?
  
  var body: some View {
    NavigationView {
      VStack(spacing: 8) {
        if recordParent != nil { // 녹음일 경우
          VStack(spacing: 0) {
            Text("") // 임시 - 여백용
              .frame(height: 8)
            
            HStack {
              Spacer()
              TextField("\(fetcher.recordTitle)", text: $recordTitle)
                .padding(16)
                .background(Color.init(hex: "#FAF8F0")) // 임시
              Spacer()
            }
            .frame(width: Screen.maxWidth, height: 80) // 임시 - 높이
            .background(Color.white)
          }
          Spacer()
        }
        
        Text("select Date")
      }
      .background(Color.init(hex: "#FAF8F0")) // 임시
      .navigationBarItems(
        leading: Button(action: {
          if image != nil { // 카메라로 들어왔을 경우,
            isCameraCancle = true // 카메라 imagePicker로 이동
          }
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Image(systemName: "chevron.left")
            Text("이전")
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          if photoParent != nil { // 갤러리 사진들
            photoParent?.presentable.wrappedValue.dismiss()
          } else if recordParent != nil { // 녹음
            recordParent?.presentable.wrappedValue.dismiss()
          } else { // 카메라
            presentable.wrappedValue.dismiss()
          }
        }, label: {
          HStack(spacing: 0) {
            Text("올리기")
          }
        })
        .disabled(isDisalbeNextButton)
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle(title)
      .onAppear {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor =
        UIColor.systemBackground.withAlphaComponent(1)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarHidden(true)
  }
}

struct AlbumSelectDateView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumSelectDateView(isCameraCancle: .constant(false))
  }
}
