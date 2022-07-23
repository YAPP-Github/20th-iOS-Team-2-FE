//
//  CameraImagePicker.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/16.
//

import UIKit
import SwiftUI

struct CameraImagePicker: UIViewControllerRepresentable {
  @Environment(\.presentationMode) private var presentationMode
  @Binding var selectedImage: UIImage
  @Binding var isNext: Bool
  //  var sourceType: UIImagePickerController.SourceType = .camera // 임시 - 추후 삭제
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<CameraImagePicker>) -> UIImagePickerController {
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .camera // 임시 - sourceType으로 앨범에 접근할 수 있음
    imagePicker.delegate = context.coordinator
    return imagePicker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraImagePicker>) {
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @ObservedObject var tabbarManager = TabBarManager.shared
    var parent: CameraImagePicker
    
    init(_ parent: CameraImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        parent.selectedImage = image
        parent.isNext = true // 날짜 선택으로
      }
      tabbarManager.showTabBar = true
      parent.presentationMode.wrappedValue.dismiss() // image picker 닫기
    }
  }
}
