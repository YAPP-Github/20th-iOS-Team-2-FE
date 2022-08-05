//
//  Album.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import Foundation

struct AlbumDefaulAPIResponse: Hashable, Decodable {
  let timestamp: String?
  let status: Int?
  let detail: String?
}

struct AlbumDateAPIResponse: Hashable, Decodable {
  let results: AlbumDateResult
  let info: Info
}

struct AlbumDateResult: Hashable, Decodable {
  let albums: [AlbumDate]
}

struct AlbumTypeAPIResponse: Hashable, Decodable {
  let favourite: AlbumKind
  let photo: AlbumKind
  let recording: AlbumKind
}

struct AlbumDate: Hashable, Decodable {
  let albumId: Int
  let title: String
  let thumbnail: String
  let date: String
}

struct AlbumKind: Hashable, Decodable {
  let kind: String
  let count: Int
}

struct Info: Hashable, Decodable {
  let totalCount: Int // pagination이 적용안된 전체 element 개수
  let pageCount: Int  // pagination이 적용된 전체 element의 페이지 개수
  let pageSize: Int   // 한 page에 들어간 element 개수
}
