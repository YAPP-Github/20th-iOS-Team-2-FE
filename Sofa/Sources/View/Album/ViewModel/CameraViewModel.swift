//
//  CameraViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/16.
//

import SwiftUI

class CameraViewModel: ObservableObject {
  @Published var showPicker = false
  @Published var showErrorAlert = false
  @Published var cameraError: CameraAuthorization.CameraErrorType?
    
  // camera picker 보기 전, 권한 확인
  func showCameraPicker() {
    do {
      try CameraAuthorization.checkPermissions()
      showPicker = true
    } catch { // 권한 오류가 발생
      showErrorAlert = true
      cameraError = CameraAuthorization.CameraErrorType(error: error as! CameraAuthorization.PickerError)
    }
  }
}
