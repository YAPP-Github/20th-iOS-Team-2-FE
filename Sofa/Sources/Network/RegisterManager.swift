//
//  RegisterManager.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/22.
//

import Foundation
import Alamofire
import Combine

enum RegisterManager: URLRequestConvertible {
  
  case registerUser(name: String, roleInFamily: String, birthDay: String, nickname: String)
  case registerFamily(familyName: String, familyMotto: String)
  case getUserSimple
  case getUserDetail
  
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
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    headers["Authorization"] = accessToken
    
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
    }
    return request
  }
}
