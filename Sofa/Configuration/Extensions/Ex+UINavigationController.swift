//
//  Ex+UINavigationController.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/08.
//

import Foundation
import SwiftUI
import UIKit

extension UINavigationController { // Backbutton Custom
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: nil, action: nil)
    }
}
