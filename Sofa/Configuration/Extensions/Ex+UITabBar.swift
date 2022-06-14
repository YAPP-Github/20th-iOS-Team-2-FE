//
//  Ex+UITabBar.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/09.
//

import UIKit.UITabBar
import SwiftUI

public extension UITabBar {
  
  // Tab View가 사용되는 경우, tab Bar 'isHidden' 매개변수 값 가져오기
  static func isHidden(_ completion: @escaping (Bool) -> Void)  {
    DispatchQueue.main.async {
      let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
      windowScene?.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
        if let view = v as? UITabBar {
          completion(view.isHidden)
        }
      })
    }
  }
  
  // Tab View가 표시되는 경우, Toggle 기능
  static func toogleTabBarVisibility(animated: Bool = true) {
    UITabBar.isHidden { isHidden in
      if isHidden {
        UITabBar.showTabBar(animated: animated)
      }
      else {
        UITabBar.hideTabBar(animated: animated)
      }
    }
  }
  
  // Tab View가 사용되는 경우 Tab 표시
  static func showTabBar(animated: Bool = true) {
    DispatchQueue.main.async {
      let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
      windowScene?.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
        if let view = v as? UITabBar {
          view.setIsHidden(false, animated: animated)
        }
      })
    }
  }
  
  // Tab View가 사용되는 경우. Tab 숨기기
  static func hideTabBar(animated: Bool = true) {
    DispatchQueue.main.async {
      let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
      windowScene?.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ (v) in
        if let view = v as? UITabBar {
          view.setIsHidden(true, animated: animated)
        }
      })
    }
  }
  
  // 애니메이션이 있는 Tab View를 숨기거나 표시하기 위한 로직
  private func setIsHidden(_ hidden: Bool, animated: Bool) {
    let isViewHidden = self.isHidden
    
    if animated {
      if self.isHidden && !hidden {
        self.isHidden = false
        self.frame.origin.y = Screen.maxHeight + 200
      }
      
      if isViewHidden && !hidden {
        self.alpha = 0.0
      }
      
      UIView.animate(withDuration: 0.8, animations: {
        self.alpha = hidden ? 0.0 : 1.0
      })
      UIView.animate(withDuration: 0.6, animations: {
        
        if !isViewHidden && hidden {
          self.frame.origin.y = Screen.maxHeight + 200
        }
        else if isViewHidden && !hidden {
          self.frame.origin.y = Screen.maxHeight - self.frame.height
        }
      }) { _ in
        if hidden && !self.isHidden {
          self.isHidden = true
        }
      }
    } else {
      if !isViewHidden && hidden {
        self.frame.origin.y = Screen.maxHeight + 200
      }
      else if isViewHidden && !hidden {
        self.frame.origin.y = Screen.maxHeight - self.frame.height
      }
      self.isHidden = hidden
      self.alpha = 1
    }
  }
}

// MARK: - UITabBarController 에 TabBar를 가져오기 위한 TabBarAccessor
struct TabBarAccessor: UIViewControllerRepresentable {
  var callback: (UITabBar) -> Void
  private let proxyController = ViewController()
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
  UIViewController {
    proxyController.callback = callback
    return proxyController
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
  }
  
  func getHight() -> CGFloat {
    return proxyController.hight
  }
  
  typealias UIViewControllerType = UIViewController
  
  // viewWillAppear 가 탈때 가지고 있는 탭바를 클로저 콜백으로 넘김
  private class ViewController: UIViewController {
    var callback: (UITabBar) -> Void = { _ in }
    var hight: CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      if let tabBar = self.tabBarController {
        self.hight = tabBar.tabBar.bounds.height
        self.callback(tabBar.tabBar)
      }
    }
  }
}
