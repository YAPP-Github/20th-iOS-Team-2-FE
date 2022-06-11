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
  
  // 권한 확인
  func requestAuthorization() {
    PHPhotoLibrary.requestAuthorization { [weak self] (status) in
      guard let self = self else { return }
      
      switch status {
      case .authorized:
        self.fetchAllImage()
      case .denied:
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
  
  private func fetchAllImage() {
    let fetchOptions = PHFetchOptions()
    fetchOptions.fetchLimit = 10 // 개수 제한
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] // 날짜 순으로 Asset
    
    let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) // only 이미지
    
    if fetchResult.count == 0 { // 가져올 이미지가 없을 경우,
      return
    }
    

    fetchResult.enumerateObjects { (asset, index, stop) in
    }
    
    DispatchQueue.main.async { [weak self] in
    }
  }
}
