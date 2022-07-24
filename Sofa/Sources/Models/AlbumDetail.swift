//
//  AlbumDetail.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/12.
//

import Foundation

struct AlbumDetailAPIResponse: Hashable, Decodable {
  let results: AlbumDetailResult
  let info: Info
}

struct AlbumDetailResult: Hashable, Decodable {
  let title: String?
  let type: String?
  let elements: [AlbumDetailElement]
}

struct AlbumDetailElement: Identifiable, Hashable, Decodable {
  var id : Int?
  let kind: String // PHOTO, RECORDING
  let fileId: Int
  let date: String
  let link: String
  let favourite: Bool
  let commentCount: Int
}

//MARK: - 즐겨찾기
struct AlbumFavouriteAPIResponse: Hashable, Decodable {
  let result: Bool
}
