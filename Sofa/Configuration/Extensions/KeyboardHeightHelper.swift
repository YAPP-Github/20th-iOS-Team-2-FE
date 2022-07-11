//
//  KeyboardHeightHelper.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/11.
//

import UIKit
import Foundation
import Combine

class KeyboardHeightHelper: ObservableObject {
  @Published var keyboardHeight: CGFloat = 0
  
  init(){
    self.listenForKeyboardNotifications()
  }
  
  private func listenForKeyboardNotifications() {
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                           object: nil,
                                           queue: .main) { (notification) in
      guard let userInfo = notification.userInfo,
            let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
      
      self.keyboardHeight = keyboardRect.height
    }
    
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                           object: nil,
                                           queue: .main) { (notification) in
      self.keyboardHeight = 0
    }
  }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
