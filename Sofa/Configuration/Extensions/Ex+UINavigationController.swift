//
//  Ex+UINavigationController.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/08.
//

import Foundation
import SwiftUI
import UIKit

extension UINavigationController { // Backbutton Custom
  open override func viewWillLayoutSubviews() {
    navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: nil, action: nil)
    navigationBar.barTintColor = .white
    // navigationBar 아래 line 투명하게
    navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationBar.shadowImage = UIImage()
  }
}

extension UINavigationController: UIGestureRecognizerDelegate{
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
    
  }
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
