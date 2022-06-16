//
//  CameraImagePicker.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/16.
//

import UIKit
import SwiftUI

struct CameraImagePicker: UIViewControllerRepresentable {
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<CameraImagePicker>) -> UIImagePickerController {
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .camera // 임시 - sourceType으로 앨범에 접근할 수 있음
    return imagePicker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraImagePicker>) {
  }
  
  func makeCoordinator() -> Coordinator {
  }
}
