//
//  UserPatchResponse.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/30.
//

import Foundation

struct UserPatchResponse: Decodable {
  let timestamp: String?
  let status: Int?
  let error: String?
  let path: String?
  let detail: String?
}
