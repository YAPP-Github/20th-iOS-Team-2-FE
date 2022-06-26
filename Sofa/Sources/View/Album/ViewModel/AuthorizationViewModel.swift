//
//  AuthorizationViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/16.
//

import SwiftUI

class AuthorizationViewModel: ObservableObject {
  @Published var showErrorAlert = false
  @Published var showErrorAlertTitle = "오류"
  
  // 카메라 권한 확인
  @Published var showPicker = false
  @Published var cameraError: CameraAuthorization.CameraErrorType?
  
  // 녹음 권한 확인
  @Published var showRecord = false
  @Published var recordError: RecordAuthorization.RecordErrorType?
    
  // camera picker 보기 전, 권한 확인
  func showCameraPicker() {
    do {
      try CameraAuthorization.checkPermissions()
      showPicker = true
    } catch { // 권한 오류가 발생
      showErrorAlert = true
      showErrorAlertTitle = "카메라 접근 오류"
      cameraError = CameraAuthorization.CameraErrorType(error: error as! CameraAuthorization.PickerError)
    }
  }
  
  // Record 보기 전, 권한 확인
  func showAudioRecord() {
    do {
      try RecordAuthorization.checkPermissions()
      showRecord = true
    } catch { // 권한 오류가 발생
      showErrorAlert = true
      showErrorAlertTitle = "녹음 접근 오류"
      recordError = RecordAuthorization.RecordErrorType(error: error as! RecordAuthorization.RecordError)
    }
  }
}
