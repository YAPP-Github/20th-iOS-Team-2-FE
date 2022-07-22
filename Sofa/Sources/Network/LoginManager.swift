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
  case postappleLogin(identityToken: String, authoriztionCode: String, userId: String)

  var baseURL: URL {
    switch self {
    case .postkakaoLogin:
      return URL(string: "\(APIConstants.url)/auth?kind=kakao")!
    case .postappleLogin:
      return URL(string: "\(APIConstants.url)/auth?kind=apple")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .postkakaoLogin:
      return .post
    case .postappleLogin:
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
    case .postkakaoLogin(let accessToken, let refreshToken):
      params["accessToken"] = accessToken
      params["refreshToken"] = refreshToken
      return params
    case .postappleLogin(let identityToken, let authoriztionCode, let userId):
      params["identityToken"] = identityToken
      params["authoriztionCode"] = authoriztionCode
      params["userId"] = userId
      
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

