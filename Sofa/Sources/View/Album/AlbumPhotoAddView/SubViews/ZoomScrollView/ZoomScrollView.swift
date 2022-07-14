//
//  ZoomScrollView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/17.
//

import SwiftUI

struct ZoomScrollView<Content: View>: UIViewRepresentable {
  private var content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  func makeUIView(context: Context) -> UIScrollView {
    // UIScrollView 설정
    let scrollView = UIScrollView()
    scrollView.delegate = context.coordinator  // coordinator 설정
    scrollView.maximumZoomScale = 20
    scrollView.minimumZoomScale = 1
    scrollView.bouncesZoom = true
    // SwiftUI View를 담을 UIHostingController 생성
    let hostedView = context.coordinator.hostingController.view!
    hostedView.translatesAutoresizingMaskIntoConstraints = true
    hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    hostedView.frame = scrollView.bounds
    hostedView.backgroundColor = .black
    scrollView.addSubview(hostedView)
    return scrollView
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(hostingController: UIHostingController(rootView: self.content))
  }
  
  func updateUIView(_ uiView: UIScrollView, context: Context) {
    // 업데이트 UIHostingController
    uiView.setZoomScale(1.0, animated: true)
    context.coordinator.hostingController.rootView = self.content
    assert(context.coordinator.hostingController.view.superview == uiView)
  }
  
  class Coordinator: NSObject, UIScrollViewDelegate {
    var hostingController: UIHostingController<Content>
    
    init(hostingController: UIHostingController<Content>) {
      self.hostingController = hostingController
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return hostingController.view
    }
    
    // scrollView가 끝났을때 돌아가기
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
      self.centerImage()
    }
    
    func centerImage() {
      let boundsSize = UIScrollView().bounds.size // 초기 UIScrollView
      var frameToCenter = hostingController.view.frame // 바뀐 frame
      
      if frameToCenter.size.width < boundsSize.width {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
      } else {
        frameToCenter.origin.x = 0
      }
      
      if frameToCenter.size.height < boundsSize.height {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
      } else {
        frameToCenter.origin.y = 0
      }
      
      hostingController.view.frame = frameToCenter
    }
  }
}

