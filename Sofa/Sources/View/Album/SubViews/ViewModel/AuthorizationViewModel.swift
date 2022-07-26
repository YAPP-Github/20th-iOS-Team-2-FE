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
  @Published var showErrorAlertMessage = "오류"
  
  // 앨범 권한 확인
  @Published var showAlbum = false
  @Published var photoAlubmError: PhotoAlbumAuthorization.PhotoAlbumErrorType?
  
  // 카메라 권한 확인
  @Published var showCamera = false
  @Published var cameraError: CameraAuthorization.CameraErrorType?
  
  // 녹음 권한 확인
  @Published var showRecord = false
  @Published var recordError: RecordAuthorization.RecordErrorType?
  
  // Photo Alum 보기 전, 권한 확인
  func showPhotoAlbum() {
    do {
      try PhotoAlbumAuthorization.checkPermissions()
      showAlbum = true
    } catch { // 권한 오류가 발생
      showErrorAlert = true
      showErrorAlertTitle = "앨범 접근 오류"
      photoAlubmError = PhotoAlbumAuthorization.PhotoAlbumErrorType(error: error as! PhotoAlbumAuthorization.PhotoAlbumError)
      showErrorAlertMessage = photoAlubmError!.message
    }
  }
  
  // Photo Alum 추가 전, 권한 확인
  func showPhotoAlbum(selectImage: UIImage) {
    do {
      try PhotoAlbumAuthorization.checkAddPermissions() { [weak self] (true) in
        self?.showAlbum = true
        UIImageWriteToSavedPhotosAlbum(selectImage, self, nil, nil) // 이미지 다운로드
      }
    } catch { // 권한 오류가 발생
      showErrorAlert = true
      showErrorAlertTitle = "앨범 접근 오류"
      photoAlubmError = PhotoAlbumAuthorization.PhotoAlbumErrorType(error: error as! PhotoAlbumAuthorization.PhotoAlbumError)
      showErrorAlertMessage = photoAlubmError!.message
    }
  }
  
  // camera picker 보기 전, 권한 확인
  func showCameraPicker() {
    do {
      try CameraAuthorization.checkPermissions()
      showCamera = true
    } catch { // 권한 오류가 발생
      showErrorAlert = true
      showErrorAlertTitle = "카메라 접근 오류"
      cameraError = CameraAuthorization.CameraErrorType(error: error as! CameraAuthorization.PickerError)
      showErrorAlertMessage = cameraError!.message
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
      showErrorAlertMessage = recordError!.message
    }
  }
}
