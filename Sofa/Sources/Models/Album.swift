//
//  Album.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/07.
//

import Foundation

struct Album: Hashable, Decodable {
    let albumId: Int
    let title: String
    let thumbnail: String
    let date: String
}
