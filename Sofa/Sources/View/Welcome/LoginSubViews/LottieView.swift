//
//  LottieView.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/14.
//

import SwiftUI
import Lottie

enum ProgressKeyFrames: CGFloat {

  case start = 0
  
  case end = 700

  
}

struct LottieView: UIViewRepresentable {
  
  typealias UIViewType = UIView
  var filename: String
  let animationView = AnimationView()
  @Binding var frame_cnt: Int
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: .zero)
  
    //4. Add animation
    //사용자 애니메이션 파일명
    animationView.animation = Animation.named(filename)
    //애니메이션 크기가 적절하게 조정될 수 있도록
    animationView.contentMode = .scaleAspectFit
    animationView.loopMode = .playOnce
    //애니메이션 재생
    animationView.play(fromFrame: ProgressKeyFrames.start.rawValue, toFrame: ProgressKeyFrames.end.rawValue, loopMode: .none)
    
    //컨테이너의 너비와 높이를 자동으로 지정할 수 있도록
    animationView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(animationView)
    
    //5. 자동완성 기능
    NSLayoutConstraint.activate([
        //레이아웃의 높이와 넓이의 제약
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    
    
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {

  }
  

}

//struct LottieView_Previews: PreviewProvider {
//  static var previews: some View {
//    LottieView(filename: "15025-bed")
//  }
//}
