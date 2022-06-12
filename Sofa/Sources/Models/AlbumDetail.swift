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
  let fileId: String
  let date: String
  let link: Int
  let favourite: Bool
  let commentCount: Int
}
