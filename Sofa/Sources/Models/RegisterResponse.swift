//
//  RegisterResponse.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/24.
//

import Foundation

struct RegisterResponse: Decodable {
  let timestamp: String?
  let status: Int?
  let error: String?
  let path: String?
  let detail: String?
}
