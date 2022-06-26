//
//  RecordAuthorization.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/26.
//

import AVFoundation

struct RecordAuthorization {
  
  // 권한 Error type
  enum RecordError: Error, LocalizedError {
    //    case undetermined // 녹음 권한을 부여하거나 거부하지 않았음을 나타내는 값
    case denied
    
    var errorDescription: String? {
      switch self {
      case .denied:
        return NSLocalizedString("녹음 권한을 명시적으로 거부했습니다. 권한/개인 정보/녹음를 열고 이 애플리케이션에 대한 액세스 권한을 부여하세요", comment: "")
      }
    }
    
    static func checkPermissions() throws {
      switch AVAudioSession.sharedInstance().recordPermission {
      case .denied:
        throw RecordError.denied
      default:
        break
      }
    }
    
    struct CameraErrorType {
      let error: RecordAuthorization.RecordError
      var message: String {
        error.localizedDescription
      }
    }
  }
}
