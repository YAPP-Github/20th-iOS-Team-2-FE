//
//  Album.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import Foundation

struct AlbumDateAPIResponse: Hashable, Decodable {
  let albums: [AlbumDate]
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
}
