//
//  TextLabelWithHyperlink.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/16.
//

import SwiftUI
import UIKit

struct TextLabelWithHyperlink: UIViewRepresentable {
  
  func makeUIView(context: Context) -> UITextView {
    
    let standartTextAttributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
      NSAttributedString.Key.foregroundColor: UIColor.gray
    ]
    
    let attributedText = NSMutableAttributedString(string: "‘시작하기'를 누르는 것으로 ")
    attributedText.addAttributes(standartTextAttributes, range: attributedText.range) // check extention
    
    let hyperlinkTextAttributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
      NSAttributedString.Key.foregroundColor: UIColor(hex: "439F47"),
      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
      NSAttributedString.Key.link: "https://stackoverflow.com"
    ]
    
    let textWithHyperlink = NSMutableAttributedString(string: "필수 이용약관")
    textWithHyperlink.addAttributes(hyperlinkTextAttributes, range: textWithHyperlink.range)
    attributedText.append(textWithHyperlink)
    
    
    let middleOfAttrString = NSMutableAttributedString(string: " 및 ")
    middleOfAttrString.addAttributes(standartTextAttributes, range: middleOfAttrString.range)
    attributedText.append(middleOfAttrString)
    
    let hyperlinkTextAttributes2: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
      NSAttributedString.Key.foregroundColor: UIColor(hex: "439F47"),
      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
      NSAttributedString.Key.link: "https://stackoverflow.com"
    ]
    
    
    let textWithHyperlink2 = NSMutableAttributedString(string: "개인정보 이용방침")
    textWithHyperlink2.addAttributes(hyperlinkTextAttributes2, range: textWithHyperlink2.range)
    attributedText.append(textWithHyperlink2)
    
    
    let endOfAttrString = NSMutableAttributedString(string: "에 동의하고 서비스를 이용합니다.")
    endOfAttrString.addAttributes(standartTextAttributes, range: endOfAttrString.range)
    attributedText.append(endOfAttrString)
    
    attributedText.enumerateAttributes(in: NSRange(location: 0, length: attributedText.length), options: []) { attributes, range, stop in
      attributedText.removeAttribute(.underlineStyle, range: range)

    }
    
    let textView = UITextView()
    textView.attributedText = attributedText
    
    textView.isEditable = false
    textView.textAlignment = .center
    textView.isSelectable = true
    textView.linkTextAttributes = [
            .foregroundColor: UIColor(hex: "439F47")
        ]
    return textView
  }
  
  func updateUIView(_ uiView: UITextView, context: Context) {}
  
}

extension NSMutableAttributedString {
  
  var range: NSRange {
    NSRange(location: 0, length: self.length)
  }
  
}
