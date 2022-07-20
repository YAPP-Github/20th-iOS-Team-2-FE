//
//  UploadManager.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/19.
//

import Alamofire
import Combine

enum UploadManager: URLRequestConvertible {
  
  case postFiles
  
  var baseURL: URL {
    switch self {
    case .postFiles:
      return URL(string: "\(APIConstants.url)/files")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .postFiles:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    headers["Authorization"] = accessToken
    
    switch self {
    case .postFiles:
      headers["Content-Type"] = "multipart/form-data"
      return headers
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    request = try URLEncoding.default.encode(request, with: nil)
    
    return request
  }
}

