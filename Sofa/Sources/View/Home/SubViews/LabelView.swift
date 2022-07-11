//
//  LabelView.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/25.
//

import Foundation
import UIKit
import SwiftUI

struct LabelView: View {
  var text: String
  
  @State private var height: CGFloat = .zero
  
  var body: some View {
    InternalLabelView(text: text, dynamicHeight: $height)
      .frame(minHeight: height)
  }
  
  struct InternalLabelView: UIViewRepresentable {
    var text: String
    @Binding var dynamicHeight: CGFloat
    
    func makeUIView(context: Context) -> UILabel {
      let label = UILabel()
      label.numberOfLines = 0
      label.lineBreakMode = .byCharWrapping
      label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
      label.font = UIFont(name: "Pretendard-Regular", size: 14)
      
      return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
      uiView.text = text
      
      DispatchQueue.main.async {
        dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width, height: CGFloat.greatestFiniteMagnitude)).height
      }
    }
  }
}
