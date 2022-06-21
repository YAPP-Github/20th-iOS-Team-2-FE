//
//  Ex+UIDevice.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/19.
//

import Foundation
import UIKit

extension UIDevice { // SE VS 그 외 디바이스 구분
  var hasNotch: Bool {
    let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
    return bottom > 0
  }
}
