//
//  NewChatResponse.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/31.
//

import Foundation

struct NewChatResponse: Decodable {
  let timestamp: String? // 실패
  let status: Int? // 실패
  let detail: String? // 실패
  let userId: Int? // 성공
  let name: String? // 성공
  let content: String? // 성공
  let updatedAt: String?
}
