//
//  CustomBoldLabelView.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import Foundation
import UIKit
import SwiftUI

struct CustomBoldLabelView: View {
  var text1: String
  var text2: String
  var user: String
  var task: String
  
  
  @State private var height: CGFloat = .zero
  
  var body: some View {
    InternalLabelView(text1: text1, text2: text2, user: user, task: task, dynamicHeight: $height)
      .frame(minHeight: height)
  }
  
  struct InternalLabelView: UIViewRepresentable {
    var text1: String
    var text2: String
    var user: String
    var task: String
    
    @Binding var dynamicHeight: CGFloat
    
    func makeUIView(context: Context) -> UILabel {

      let boldTextAttributes: [NSAttributedString.Key : Any] = [ // 강조 attribute
        NSAttributedString.Key.font: UIFont(name: "Pretendard-Bold", size: 14) ??  UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
      
      let defaultTextAttributes: [NSAttributedString.Key : Any] = [ // 기본 attribute
        NSAttributedString.Key.font: UIFont(name: "Pretendard-Regular", size: 14) ??  UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.black
      ]
      
      let attributedText1 = NSMutableAttributedString(string: user)
      attributedText1.addAttributes(boldTextAttributes, range: attributedText1.range) // check extention
      
      let boldText1 = NSMutableAttributedString(string: text1)
      boldText1.addAttributes(defaultTextAttributes, range: boldText1.range)
      attributedText1.append(boldText1)
      
      let attributedText2 = NSMutableAttributedString(string: task)
      attributedText2.addAttributes(boldTextAttributes, range: attributedText2.range) // check extention
      attributedText1.append(attributedText2)
      
      let boldText2 = NSMutableAttributedString(string: text2)
      boldText2.addAttributes(defaultTextAttributes, range: boldText2.range)
      attributedText1.append(boldText2)

      let label = UILabel()
      label.numberOfLines = 0
      label.lineBreakMode = .byCharWrapping
      label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
      label.font = UIFont(name: "Pretendard-Regular", size: 14)
      label.attributedText = attributedText1
      
      return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {

      DispatchQueue.main.async {
        dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
      }
    }
  }
}


extension NSMutableAttributedString {
  
  var range: NSRange {
    NSRange(location: 0, length: self.length)
  }
  
}
