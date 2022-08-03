//
//  MessageResponse.swift
//  Sofa
//
//  Created by 양유진 on 2022/08/04.
//

import Foundation

struct MessageResponse: Decodable {
  let timestamp: String? // 실패
  let status: Int? // 실패
  let detail: String? // 실패
  let path: String? // 실패
}

