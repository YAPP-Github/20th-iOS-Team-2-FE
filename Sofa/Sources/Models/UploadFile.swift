//
//  UploadFile.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/19.
//

import Foundation
import SwiftUI
import Photos

struct UploadFilesAPIResponse: Hashable, Decodable {
  let links: [String]
}

struct Photo: Hashable {
  var isSelect: Bool
  var asset: Asset
}

struct SelectedImages: Hashable {
  var asset : PHAsset
  var image : UIImage
}

