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
    let yourBackImage = UIImage(systemName: "arrow.left")
//    self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
//    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//    self.navigationController?.navigationBar.backItem?.title = "Custom"
    navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navigationBar.backIndicatorImage = yourBackImage
    navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    navigationBar.barTintColor = .white
    // navigationBar 아래 line 투명하게
    navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationBar.shadowImage = UIImage()
  }
}
