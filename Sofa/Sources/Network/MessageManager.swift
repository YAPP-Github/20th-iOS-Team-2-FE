//
//  MessageManager.swift
//  Sofa
//
//  Created by 양유진 on 2022/08/04.
//

import Foundation
import Alamofire
import Combine

enum MessageManager: URLRequestConvertible {
  
  case postMessage(content: String)
  case postEmoji(content: Int)
  
  var baseURL: URL {
    switch self {
    case let .postMessage:
      return URL(string: "\(APIConstants.url)/family/greeting/message")!
      
    case let .postEmoji:
      return URL(string: "\(APIConstants.url)/family/greeting/emoji")!
      
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .postMessage:
      return .post
    case .postEmoji:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    headers["Authorization"] = accessToken
    
    switch self {
    case .postMessage:
      headers["Content-Type"] = "application/json"
    case .postEmoji:
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
  
  var parameters: Parameters {
    var params = Parameters()

    switch self {
    case let .postMessage(content):
      params["content"] = content
    case let .postEmoji(content):
      params["content"] = content
    }
    return params
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    switch self {
    case .postMessage:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .postEmoji:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    }
    
    return request
  }
}
