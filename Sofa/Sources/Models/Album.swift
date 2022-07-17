//
//  Album.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import Foundation

struct AlbumDateAPIResponse: Hashable, Decodable {
  let info: Info
  let albums: [AlbumDate]
}

struct AlbumTypeAPIResponse: Hashable, Decodable {
  let favourite: AlbumType
  let photo: AlbumType
  let recording: AlbumType
}

struct AlbumDate: Hashable, Decodable {
  let albumId: Int
  let title: String
  let thumbnail: String
  let date: String
}

struct AlbumType: Hashable, Decodable {
  let kind: String
  let count: Int
  let link: String

struct Info: Hashable, Decodable {
  let totalCount: Int // pagination이 적용안된 전체 element 개수
  let pageCount: Int  // pagination이 적용된 전체 element의 페이지 개수
  let pageSize: Int   // 한 page에 들어간 element 개수
}
