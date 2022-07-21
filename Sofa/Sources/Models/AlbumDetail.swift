//
//  AlbumDetail.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import Foundation

struct AlbumDetailAPIResponse: Hashable, Decodable {
  let title: String?
  let type: String?
  let elements: [AlbumDetailElement]
}

struct AlbumDetailElement: Identifiable, Hashable, Decodable {
  var id : Int?
  let type: String // PHOTO, RECORDING
  let fileId: Int
  let date: String
  let link: String
  let favourite: Bool
  let title: String? // RECORDING일 경우
  let commentCount: Int
}
