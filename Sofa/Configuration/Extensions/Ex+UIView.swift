//
//  Ex+UIView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import UIKit.UIView

extension UIView {
  
  func allSubviews() -> [UIView] {
    var allSubviews = subviews
    for subview in subviews {
      allSubviews.append(contentsOf: subview.allSubviews())
    }
    return allSubviews
  }
}
