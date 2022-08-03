//
//  HomeInfoManager.swift
//  Sofa
//
//  Created by 양유진 on 2022/08/03.
//

import Foundation
import Alamofire
import Combine

enum HomeInfoManager: URLRequestConvertible {

  case getHomeInfo
  
  var baseURL: URL {
    switch self {
    case .getHomeInfo:
      return URL(string: "\(APIConstants.url)/family/home")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getHomeInfo:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    headers["Authorization"] = accessToken
    
    switch self {
    case .getHomeInfo:
      return headers
    }
  }
  
  var parameters: Parameters {
    var params = Parameters()
    
    switch self {
    case .getHomeInfo:
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

