//
//  CameraAuthorization.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/16.
//

import SwiftUI

struct CameraAuthorization {
  
  // 권한 Error type
  enum PickerError: Error, LocalizedError {
    case unavailable
    case restricted
    case denied
    
    var errorDescription: String? {
      switch self {
      case .unavailable: // 카메라가 없을 경우,
        return NSLocalizedString("이 기기에 사용 가능한 카메라가 없습니다", comment: "")
      case .denied:
        return NSLocalizedString("카메라 접근 권한을 명시적으로 거부했습니다. 권한/개인 정보/카메라를 열고 이 애플리케이션에 대한 액세스 권한을 부여하세요", comment: "")
      case .restricted:
        return NSLocalizedString("카메라에 접근할 수 없습니다", comment: "")
      }
    }
  }
}
