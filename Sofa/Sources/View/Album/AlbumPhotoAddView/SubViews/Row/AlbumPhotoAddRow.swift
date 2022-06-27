//
//  AlbumPhotoAddRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI
import Photos

struct AlbumPhotoAddRow: View {
  @StateObject var asset: Asset
  @Binding var selected: [SelectedImages]
  @Binding var imageClick: UIImage?
  @State var isSelect: Bool
  @State private var showAlert = false
  private let size = Screen.maxWidth * 0.325
  private let limit = 3
  
  var body: some View {
    ZStack {
      Button(action: {
        if isSelect { // 이미 선택되어 있을때,
          let removeTarget = selected.filter{$0.asset == asset.asset}
          let removeIndex = selected.firstIndex(of: removeTarget[0])!
          selected.remove(at: removeIndex)
          imageClick = asset.image!
          isSelect = false
        } else if selected.count < limit { // 선택이 안되어 있고, 3개 이하일 경우
          selected.append(SelectedImages(asset: asset.asset, image: asset.image!))
          imageClick = asset.image!
          isSelect = true
        } else { // 알림
          showAlert = true
        }
      }, label: {
        if asset.image != nil {
          Image(uiImage: asset.image!)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size, alignment: .center)
            .cornerRadius(5.0)
        } else {
          Color.gray
            .frame(width: size, height: size)
            .cornerRadius(5.0)
        }
      })
      .alert(isPresented: $showAlert) {
        Alert(
          title: Text("\(limit)개 이상 추가할 수 없습니다"),
          message: nil,
          dismissButton: .default(Text("확인")))
      }
      Circle()
        .strokeBorder(Color.white, lineWidth: 1)
        .frame(width: 24, height: 24, alignment: .center)
        .background(Circle().foregroundColor(isSelect ? Color.init(hex: "#43A047") : Color(UIColor.gray.withAlphaComponent(0.6)))) // 임시 컬러
        .offset(x: size/3, y: -(size/3))
        .overlay(
          Text(
            selected.filter{$0.asset == asset.asset}.first != nil &&
            selected.firstIndex(of: selected.filter{$0.asset == asset.asset}.first!) != nil
            ? "\(selected.firstIndex(of: selected.filter{$0.asset == asset.asset}.first!)! + 1)" : "0"
          ) // numburing 기능
            .foregroundColor(isSelect ? Color.white : Color.clear)
            .offset(x: size/3, y: -(size/3))
        )
    }
    .onAppear {
      self.asset.request()
    }
  }
}

struct AlbumPhotoAddRow_Previews: PreviewProvider {
  static var previews: some View { // click 금지, imageClick 때문에 error
    let data = UIImage(named: MockData().photoList[1])!
    AlbumPhotoAddRow(asset: Asset(asset: PHAsset()), selected: .constant([SelectedImages]()), imageClick: .constant(data), isSelect: true)
  }
}
