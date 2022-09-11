//
//  AlbumPhotoLibrary.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import SwiftUI
import Combine
import Photos

class AlbumPhotoLibrary: ObservableObject {
  @Published var photoAssets = [Photo]()
  
  // 권한 확인
  func requestAuthorization(parant: AlbumPhotoAddView) {
    PHPhotoLibrary.requestAuthorization { [weak self] (status) in
      guard let self = self else { return }
      
      switch status {
      case .authorized:
        self.fetchAllImage()
      case .denied:
        parant.presentable.wrappedValue.dismiss()
        break
      case .notDetermined:
        break
      case .restricted:
        break
      case .limited:
        break
      @unknown default:
        break
      }
    }
  }
  
  func fetchAllImage() {
    let fetchOptions = PHFetchOptions()
//    fetchOptions.fetchLimit = 1000 // 임시 개수 제한
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] // 날짜 순으로 Asset
    
    let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) // only 이미지
    
    if fetchResult.count == 0 { // 가져올 이미지가 없을 경우,
      return
    }
    
    var photoAssets = [Photo]()
    
    fetchResult.enumerateObjects { (asset, index, stop) in
      photoAssets.append(Photo(isSelect: false, asset: Asset(asset: asset)))
    }
    
    DispatchQueue.main.async { [weak self] in
      self?.photoAssets = photoAssets
    }
  }
}

class Asset: ObservableObject, Identifiable, Hashable {
  @Published var image: UIImage? = nil
  let asset: PHAsset
  
  init(asset: PHAsset) {
    self.asset = asset
  }
  
  static func == (lhs: Asset, rhs: Asset) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  private var manager = PHImageManager.default()
  func request() {
    DispatchQueue.global().async {
      self.manager.requestImage(for: self.asset, targetSize: CGSize(width: 200, height: 200),
                                contentMode: .aspectFill,
                                options: self.imageOption()) { [weak self] (image, info) in
        self?.image = image
      }
    }
  }
  
  func imageOption() -> PHImageRequestOptions {
    let imageRequestOptions = PHImageRequestOptions()
    imageRequestOptions.version = .current
    imageRequestOptions.isNetworkAccessAllowed = true   // iCloud 가능
    imageRequestOptions.deliveryMode = .highQualityFormat // 고화질
    return imageRequestOptions
  }
}
