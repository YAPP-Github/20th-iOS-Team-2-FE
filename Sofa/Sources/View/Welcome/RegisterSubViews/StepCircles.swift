//
//  StepCircles.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/10.
//

import SwiftUI

struct StepCircles: View {
  
  @Binding var currentSteps: Int
  
  var body: some View {
    HStack(spacing: 10){
      ForEach(0...3, id: \.self) { idx in
        ZStack{
          Image(systemName: "\(idx+1).circle.fill")
            .font(.system(size: 18))
            .foregroundColor(idx+1==currentSteps ? Color(hex: "#388E3C") : Color.black.opacity(0.24))
        }///ZStack
      }
    }///HStack
  }
}

struct StepCircles_Previews: PreviewProvider {
  static var previews: some View {
    RegisterView()
  }
}
