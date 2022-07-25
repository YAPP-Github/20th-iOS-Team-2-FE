//
//  CommentManger.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/25.
//

import Alamofire
import Combine

enum CommentManger: URLRequestConvertible {
  
  case getComments(fileId: Int)

  var baseURL: URL {
    switch self {
    case let .getComments(fileId):
      return URL(string: "\(APIConstants.url)/album/\(fileId)/comments")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getComments:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    headers["Authorization"] = accessToken
    
    switch self {
    case .getComments:
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
  
//  var parameters: Parameters {
//    var params = Parameters()
//
//    switch self {
//    case .getComments:
//      break
//    }
//    return params
//  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    switch self {
    case .getComments:
      request = try URLEncoding.default.encode(request, with: nil)
    }
    
    return request
  }
}

