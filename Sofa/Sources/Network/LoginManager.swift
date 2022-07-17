//
//  LoginManager.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/18.
//

import Foundation
import Alamofire
import Combine

enum LoginManager: URLRequestConvertible {
  
  case postkakaoLogin(accessToken: String, refreshToken: String)

  var baseURL: URL {
    switch self {
    case .postkakaoLogin:
      return URL(string: "\(APIConstants.url)/auth?kind=kakao")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .postkakaoLogin:
      return .post
    }
  }

//  var headers: HTTPHeaders {
//    var headers = HTTPHeaders()
//
//    switch self {
//    case .kakao:
//      return headers
//    }
//  }
  
  var parameters: Parameters {
    var params = Parameters()

    switch self {
    case .postkakaoLogin(var accessToken, var refreshToken):
      params["accessToken"] = accessToken
      params["refreshToken"] = refreshToken
      return params
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL

    var request = URLRequest(url: url)
    
    request.method = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    
    return request
  }
}

