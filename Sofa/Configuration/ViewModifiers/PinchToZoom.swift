//
//  PinchToZoom.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/11.
//

import SwiftUI

struct PinchToZoom: ViewModifier {
  @State var scale: CGFloat = 1.0
  @State var anchor: UnitPoint = .center
  @State var offset: CGSize = .zero
  @State var isPinching: Bool = false
  
  func body(content: Content) -> some View {
    content
      .scaleEffect(scale, anchor: anchor)
      .offset(offset)
      .animation(isPinching ? .none : .spring())
      .overlay(PinchZoom(scale: $scale, anchor: $anchor, offset: $offset, isPinching: $isPinching))
  }
}

struct PinchZoom: UIViewRepresentable {
  @Binding var scale: CGFloat
  @Binding var anchor: UnitPoint
  @Binding var offset: CGSize
  @Binding var isPinching: Bool
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> PinchZoomView {
    let pinchZoomView = PinchZoomView()
    pinchZoomView.delegate = context.coordinator
    return pinchZoomView
  }
  
  func updateUIView(_ pageControl: PinchZoomView, context: Context) { }
  
  class Coordinator: NSObject, PinchZoomViewDelegate {
    var pinchZoom: PinchZoom
    
    init(_ pinchZoom: PinchZoom) {
      self.pinchZoom = pinchZoom
    }
    
    func pinchZoomView(_ pinchZoomView: PinchZoomView, didChangePinching isPinching: Bool) {
      pinchZoom.isPinching = isPinching
    }
    
    func pinchZoomView(_ pinchZoomView: PinchZoomView, didChangeScale scale: CGFloat) {
      pinchZoom.scale = scale
    }
    
    func pinchZoomView(_ pinchZoomView: PinchZoomView, didChangeAnchor anchor: UnitPoint) {
      pinchZoom.anchor = anchor
    }
    
    func pinchZoomView(_ pinchZoomView: PinchZoomView, didChangeOffset offset: CGSize) {
      pinchZoom.offset = offset
    }
  }
}

protocol PinchZoomViewDelegate: AnyObject {
  func pinchZoomView(_ pinchZoomView: PinchZoomView, didChangePinching isPinching: Bool)
  func pinchZoomView(_ pinchZoomView: PinchZoomView, didChangeScale scale: CGFloat)
  func pinchZoomView(_ pinchZoomView: PinchZoomView, didChangeAnchor anchor: UnitPoint)
  func pinchZoomView(_ pinchZoomView: PinchZoomView, didChangeOffset offset: CGSize)
}

class PinchZoomView: UIView {
  weak var delegate: PinchZoomViewDelegate?
  
  private(set) var scale: CGFloat = 0 {
    didSet {
      delegate?.pinchZoomView(self, didChangeScale: scale)
    }
  }
  
  private(set) var anchor: UnitPoint = .center {
    didSet {
      delegate?.pinchZoomView(self, didChangeAnchor: anchor)
    }
  }
  
  private(set) var offset: CGSize = .zero {
    didSet {
      delegate?.pinchZoomView(self, didChangeOffset: offset)
    }
  }
  
  private(set) var isPinching: Bool = false {
    didSet {
      delegate?.pinchZoomView(self, didChangePinching: isPinching)
    }
  }
  
  private var startLocation: CGPoint = .zero
  private var location: CGPoint = .zero
  private var numberOfTouches: Int = 0
  
  init() {
    super.init(frame: .zero)
    
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(gesture:)))
    pinchGesture.cancelsTouchesInView = false
    addGestureRecognizer(pinchGesture)
    
    backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  @objc private func pinch(gesture: UIPinchGestureRecognizer) {
    
    switch gesture.state {
    case .began:
      isPinching = true
      startLocation = gesture.location(in: self)
      anchor = UnitPoint(x: startLocation.x / bounds.width, y: startLocation.y / bounds.height)
      numberOfTouches = gesture.numberOfTouches
      
    case .changed:
      if gesture.numberOfTouches != numberOfTouches {
        // 사용하는 손가락 수가 변경되면 점프하지 않도록 시작 위치를 조정
        let newLocation = gesture.location(in: self)
        let jumpDifference = CGSize(width: newLocation.x - location.x, height: newLocation.y - location.y)
        startLocation = CGPoint(x: startLocation.x + jumpDifference.width, y: startLocation.y + jumpDifference.height)
        
        numberOfTouches = gesture.numberOfTouches
      }
      
      scale = gesture.scale
      
      location = gesture.location(in: self)
      offset = CGSize(width: location.x - startLocation.x, height: location.y - startLocation.y)
      
    case .ended, .cancelled, .failed:
      isPinching = false
      scale = 1.0
      anchor = .center
      offset = .zero
    default:
      break
    }
  }
}

struct PinchToZoom_Previews: PreviewProvider {
  static var previews: some View {
    Image(MockData().photoList[0])
      .pinchToZoom()
  }
}
