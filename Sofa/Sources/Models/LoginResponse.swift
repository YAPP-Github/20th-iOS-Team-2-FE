//
//  LoginResponse.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/18.
//

import Foundation

struct LoginResponse: Decodable {
  let timestamp: String? // 실패
  let status: Int? // 실패
  let detail: String? // 실패
  let type: String? // 성공
  let authToken: String? // 성공
}

