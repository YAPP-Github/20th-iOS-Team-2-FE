//
//  HistoryManager.swift
//  Sofa
//
//  Created by 양유진 on 2022/08/04.
//

import Foundation
import Alamofire
import Combine

enum HistoryManager: URLRequestConvertible {

  case getHistory(userId: Int)
  
  var baseURL: URL {
    switch self {
    case let .getHistory(userId):
      return URL(string: "\(APIConstants.url)/user/\(userId)/history")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getHistory:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
//    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    let accessToken = "Bearer \(Constant.accessToken ?? "")"
    headers["Authorization"] = accessToken
    
    switch self {
    case .getHistory:
      return headers
    }
  }
  
  var parameters: Parameters {
    var params = Parameters()
    
    switch self {
    case .getHistory:
      return params
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    request = try URLEncoding.default.encode(request, with: parameters)
    
    return request
  }
}

