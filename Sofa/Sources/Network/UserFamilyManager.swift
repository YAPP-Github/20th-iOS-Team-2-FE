//
//  UserFamilyManager.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/22.
//

import Foundation
import Alamofire
import Combine

enum UserFamilyManager: URLRequestConvertible {
  case registerUser(name: String, roleInFamily: String, birthDay: String, nickname: String)
  case registerFamily(familyName: String, familyMotto: String)
  case getUserSimple
  case getUserDetail
  case patchUser(imageLink: String, birthDay: String, roleInFamily: String, nickname: String)
  case patchFamily(familyName: String, familyMotto: String, nickname: [Nickname])
  case getFamily
                  
  var baseURL: URL {
    switch self {
    case .registerUser:
      return URL(string: "\(APIConstants.url)/user")!
    case .registerFamily:
      return URL(string: "\(APIConstants.url)/family")!
    case .getUserSimple:
      return URL(string: "\(APIConstants.url)/user/simple")!
    case .getUserDetail:
      return URL(string: "\(APIConstants.url)/user/detail")!
    case .patchUser:
      return URL(string: "\(APIConstants.url)/user")!
    case .patchFamily:
      return URL(string: "\(APIConstants.url)/family")!
    case .getFamily:
      return URL(string: "\(APIConstants.url)/family")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .registerUser:
      return .post
    case .registerFamily:
      return .post
    case .getUserSimple:
      return .get
    case .getUserDetail:
      return .get
    case .patchUser:
      return .patch
    case .patchFamily:
      return .patch
    case .getFamily:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    headers["Authorization"] = "Bearer \(Constant.accessToken ?? "")"
    switch self {
    case .registerUser:
      headers["Content-Type"] = "application/json"
      headers["accept"] = "application/json"
    case .registerFamily:
      headers["Content-Type"] = "application/json"
      headers["accept"] = "application/json"
    case .getUserSimple:
      return headers
    case .getUserDetail:
      return headers
    case .patchUser:
      headers["Content-Type"] = "application/json"
      headers["accept"] = "application/json"
    case .patchFamily:
      headers["Content-Type"] = "application/json"
      headers["accept"] = "application/json"
    case .getFamily:
      return headers
    }
    return headers
  }
  
  var parameters: Parameters {
    var params = Parameters()
    switch self {
    case let .registerUser(name: name, roleInFamily: roleInFamily, birthDay: birthDay, nickname: nickname):
      params["name"] = name
      params["roleInFamily"] = roleInFamily
      params["birthDay"] = birthDay
      params["nickname"] = nickname
    case let .registerFamily(familyName: familyName, familyMotto: familyMotto):
      params["familyName"] = familyName
      params["familyMotto"] = familyMotto
    case .getUserSimple:
      break
    case .getUserDetail:
      break
    case let .patchUser(imageLink: imageLink, birthDay: birthDay, roleInFamily: roleInFamily, nickname: nickname):
      params["imageLink"] = imageLink
      params["birthDay"] = birthDay
      params["roleInFamily"] = roleInFamily
      params["nickname"] = nickname
    case let .patchFamily(familyName: familyName, familyMotto: familyMotto, nickname: nickname):
      params["familyName"] = familyName
      params["familyMotto"] = familyMotto
      params["nickname"] = nickname
    case .getFamily:
      break
    }
    return params
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    switch self {
    case .registerUser:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .registerFamily:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .getUserSimple:
      request = try URLEncoding.default.encode(request, with: nil)
    case .getUserDetail:
      request = try URLEncoding.default.encode(request, with: nil)
    case .patchUser:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .patchFamily:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .getFamily:
      request = try URLEncoding.default.encode(request, with: nil)
    }
    return request
  }
}
