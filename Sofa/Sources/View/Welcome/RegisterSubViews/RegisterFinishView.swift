//
//  RegisterFinishView.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/13.
//

import SwiftUI

struct RegisterFinishView: View {
  
  @State var showFamilyRegister: Bool = false
  
  var body: some View {
    
    Button(action: {
      self.showFamilyRegister = true
    }){
      Image("cta")
    }
    .fullScreenCover(isPresented: $showFamilyRegister, content: RegisterFamilyView.init)
  }
}

struct RegisterFinishView_Previews: PreviewProvider {
  static var previews: some View {
    RegisterFinishView()
  }
}
