//
//  Color.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/06.
//

import Foundation
import SwiftUI
import Photos

//struct Photo: Hashable {
//  var isSelect: Bool
//  var asset: Asset
//}

//struct SelectedImages: Hashable {
//  var asset : PHAsset
//  var image : UIImage
//}

struct currentColor: Hashable {
  var color: String
  var isSelect: Bool
}

struct SelectedColor: Hashable {
  var currentColor: String
}
