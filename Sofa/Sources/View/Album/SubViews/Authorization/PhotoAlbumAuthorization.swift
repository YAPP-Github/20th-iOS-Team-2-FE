//
//  PhotoAlbumAuthorization.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/26.
//

import SwiftUI
import Photos

struct PhotoAlbumAuthorization {
  
  // 권한 Error type
  enum PhotoAlbumError: Error, LocalizedError {
    case denied
    case restricted
    
    var errorDescription: String? {
      switch self {
      case .denied:
        return NSLocalizedString("앨범 권한을 명시적으로 거부했습니다. 설정을 눌러 애플리케이션에 대한 액세스 권한을 부여하세요", comment: "")
      case .restricted:
        return NSLocalizedString("앨범에 접근할 수 없습니다", comment: "")
      }
    }
  }
  
  static func checkPermissions() throws {
    switch PHPhotoLibrary.authorizationStatus() {
    case .denied:
      throw PhotoAlbumError.denied
    case .restricted:
      throw PhotoAlbumError.restricted
    default:
      break
    }
  }
  
  struct PhotoAlbumErrorType {
    let error: PhotoAlbumAuthorization.PhotoAlbumError
    var message: String {
      error.localizedDescription
    }
  }
}
