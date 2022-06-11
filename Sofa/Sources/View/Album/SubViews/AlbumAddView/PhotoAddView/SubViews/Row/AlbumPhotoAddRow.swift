//
//  AlbumPhotoAddRow.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI
import Photos

struct AlbumPhotoAddRow: View {
  @ObservedObject var asset: Asset
  @Binding var selected: [SelectedImages]
  @State var isSelect: Bool
  @Binding var imageClick: UIImage?
  let size = UIScreen.main.bounds.width * 0.325
  
  var body: some View {
    ZStack {
      Button(action: {
        imageClick = asset.image!
        
        if isSelect { // 이미 선택되어 있을때,
          selected.remove(at: selected.firstIndex(of: SelectedImages(asset: asset.asset, image: asset.image!))!)
          isSelect = false
        } else if selected.count < 3 { // 선택이 안되어 있고, 3개 이하일 경우
          selected.append(SelectedImages(asset: asset.asset, image: asset.image!))
          isSelect = true
        }
      }, label: {
        if asset.image != nil {
          Image(uiImage: asset.image!)
            .resizable()
            .scaledToFill()
            .frame(
              width: size,
              height: size,
              alignment: .center)
            .cornerRadius(5.0)
          
        } else {
          Color.yellow
            .frame(
              width: size,
              height: size)
            .cornerRadius(5.0)
        }
      })
      
      Circle()
        .strokeBorder(Color.white, lineWidth: 1)
        .frame(width: 24, height: 24, alignment: .center)
        .background(Circle().foregroundColor(isSelect ? Color.init(hex: "#43A047") : Color(UIColor.gray.withAlphaComponent(0.6)))) // 임시 컬러
        .offset(x: size/3, y: -(size/3))
        .overlay(
          Text(asset.image != nil && selected.firstIndex(of: SelectedImages(asset: asset.asset, image: asset.image!)) != nil ? "\(selected.firstIndex(of: SelectedImages(asset: asset.asset, image: asset.image!))! + 1)": "0") // numburing 기능
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
    AlbumPhotoAddRow(asset: Asset(asset: PHAsset()), selected: .constant([SelectedImages]()), isSelect: true, imageClick: .constant(data))
  }
}
