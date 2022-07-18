//
//  BottomLogindView.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/18.
//

import Foundation
import UIKit
import Combine


// 스크롤뷰 핼퍼
class ScrollViewHelper : NSObject, UIScrollViewDelegate, ObservableObject {
  
  @Published var isBottomValue : Bool = false
  
  let threshold : CGFloat
  lazy var isBottom : AnyPublisher<Bool, Never> = $isBottomValue.removeDuplicates() .eraseToAnyPublisher()
  
  init(threshold : CGFloat = 0){
    self.threshold = threshold
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    self.isBottomValue = isScrollBottom(scrollView)
  }
  
  fileprivate func isScrollBottom(_ scrollView : UIScrollView) -> Bool {
    return scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.frame.height < threshold
  }
}
