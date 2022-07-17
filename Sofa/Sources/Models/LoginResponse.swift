//
//  LoginResponse.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/18.
//

import Foundation

struct LoginResponse: Decodable {
  let type: String
  let authToken: String

}
