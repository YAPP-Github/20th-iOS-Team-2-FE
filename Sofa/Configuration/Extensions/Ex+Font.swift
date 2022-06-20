//
//  Ex+Font.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/20.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
  
  func apply(link: String, subString: String)  {
    if let range = self.string.range(of: subString) {
      self.apply(link: link, onRange: NSRange(range, in: self.string))
    }
  }
  private func apply(link: String, onRange: NSRange) {
    self.addAttributes([NSAttributedString.Key.link: link], range: onRange)
  }
  
}
