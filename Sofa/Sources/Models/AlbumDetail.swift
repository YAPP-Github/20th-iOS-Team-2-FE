//
//  AlbumDetail.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import Foundation

struct AlbumDetail: Hashable, Decodable {
  let title: String
  let elements: [AlbumDetailElement]
}

struct AlbumDetailElement: Hashable, Decodable {
  let type: String // PHOTO, RECORDING
  let fileId: Int
  let date: String
  let link: String
  let favourite: Bool
  let commentCount: Int
}
