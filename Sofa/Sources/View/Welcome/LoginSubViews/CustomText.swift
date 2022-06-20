//
//  CustomText.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/20.
//

import Foundation
import UIKit
import SwiftUI

class LinkText: UITextView, UITextViewDelegate {
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    print(URL)
    
    return false
  }
}

struct CustomText: UIViewRepresentable {
  @Binding var text: NSMutableAttributedString
  
  func makeUIView(context: Context) -> LinkText {
    let view = LinkText()
    
    view.dataDetectorTypes = .all
    view.isEditable        = false
    view.isSelectable      = true
    view.delegate          = view
    view.isUserInteractionEnabled = true
    view.textAlignment = .center
    
    return view
  }
  
  func updateUIView(_ uiView: LinkText, context: Context) {
    uiView.attributedText = text
    
  }
}
