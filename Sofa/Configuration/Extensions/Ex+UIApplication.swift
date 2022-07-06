//
//  Ex+UIApplication.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/06.
//

import UIKit
import SwiftUI
import Foundation

extension UIApplication {
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
 }
 
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

// 다른 화면 클릭 시 키보드 내림
struct DismissingKeyboard: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onTapGesture {
        let keyWindow = UIApplication.shared.connectedScenes
          .filter({$0.activationState == .foregroundActive})
          .map({$0 as? UIWindowScene})
          .compactMap({$0})
          .first?.windows
          .filter({$0.isKeyWindow}).first
        keyWindow?.endEditing(true)
      }
  }
}
