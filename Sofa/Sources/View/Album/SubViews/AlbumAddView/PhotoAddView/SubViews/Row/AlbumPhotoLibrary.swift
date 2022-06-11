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
}
