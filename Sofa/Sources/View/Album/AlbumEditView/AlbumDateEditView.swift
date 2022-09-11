//
//  AlbumDateEditView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/16.
//

import SwiftUI

struct AlbumDateEditView: View {
  @Environment(\.presentationMode) var presentable
  @ObservedObject var viewModel = AlbumEditViewModel()
  @State var currentDate: Date = Date()
  @State var isAlert: Bool = false
  var parant: AlbumDetailView?
  let buttonColor: Color = Color.init(hex: "#43A047") // 임시
  var albumId: Int?     // 앨범 날짜 수정
  var fileId: Int?      // 사진/녹음 날짜 수정
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        Divider()
        Spacer() // 임시 - 여백용
          .frame(height: 8)
        Group {
          GeneralDatePickerView(showDatePicker: .constant(true), enableToggle: .constant(false), currentDate: $currentDate)
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 12, trailing: 16))
        .background(Color.white)
        Divider()
        Spacer()
        if albumId != nil {
          Button(action: {
            self.isAlert = true
          }) {
            Text("앨범 삭제")
              .foregroundColor(Color.black)
              .font(.custom("Pretendard-Regular", size: 18))
              .frame(maxWidth: .infinity, minHeight: 48)
              .background(Color(hex: "#EDEADF")) // 임시
              .clipShape(RoundedRectangle(cornerRadius: 6))
              .padding([.leading, .trailing], 16)
              .padding(.bottom, 42)
          }
        }
      }
      .background(Color.init(hex: "#FAF8F0")) // 임시
      .alert(isPresented: $isAlert) {
        Alert(
          title: Text("앨범 삭제")
            .font(.custom("Pretendard-Bold", size: 18)),
          message: Text("앨범을 삭제하면 앨범에 담긴 모든 사진 및 음성 파일이 삭제됩니다")
            .font(.custom("Pretendard-Regular", size: 13)),
          primaryButton: .default(Text("취소")),
          secondaryButton: .destructive(Text("삭제")
            .font(.custom("Pretendard-Bold", size: 18))) {
              self.viewModel.deleteAlbum(albumId: albumId!)
              self.parant?.presentable.wrappedValue.dismiss()
              self.presentable.wrappedValue.dismiss()
            })
      }
      .navigationBarItems(
        leading: Button(action: {
          presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Text("취소")
              .font(.custom("Pretendard-Medium", size: 16))
              .fontWeight(.semibold)
          }
        })
        .preferredColorScheme(.light)
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)),
        trailing: Button(action: {
          let dateStr = currentDate.getFormattedDate(format: "yyyy-MM-dd") + "T" + Date().getFormattedDate(format: "hh:mm:ss")

          if albumId != nil {         // 앨범
            self.viewModel.patchAlbumDate(albumId: albumId!, date: dateStr)
            self.parant?.presentable.wrappedValue.dismiss()
          } else if fileId != nil {  // 사진
            self.viewModel.patchAlbumDetailDate(fieldId: fileId!, date: dateStr)
          }
          self.presentable.wrappedValue.dismiss()
        }, label: {
          HStack(spacing: 0) {
            Text("수정")
              .font(.custom("Pretendard-Medium", size: 16))
              .fontWeight(.semibold)
          }
        })
        .accentColor(buttonColor)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
      )
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("날짜 수정")
      .onAppear {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor =
        UIColor.systemBackground.withAlphaComponent(1)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
      }
      .edgesIgnoringSafeArea([.bottom]) // Bottom만 safeArea 무시
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .navigationBarHidden(true)
  }
}

struct AlbumEditDateView_Previews: PreviewProvider {
  static var previews: some View {
    AlbumDateEditView(parant: AlbumDetailView(listViewModel: AlbumDetailListViewModel(albumId: nil, kindType: nil), title: "앨범 상세", selectAlbumId: 0, selectKindType: ""))
  }
}
