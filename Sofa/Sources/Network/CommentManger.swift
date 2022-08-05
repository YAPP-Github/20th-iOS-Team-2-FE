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
  case postComments(fileId: Int, content: String)
  case patchComment(commentId: Int, content: String)
  
  var baseURL: URL {
    switch self {
    case let .getComments(fileId):
      return URL(string: "\(APIConstants.url)/album/\(fileId)/comments")!
    case let .postComments(fileId, _):
      return URL(string: "\(APIConstants.url)/album/\(fileId)/comments")!
    case let .patchComment(commentId, _):
      return URL(string: "\(APIConstants.url)/album/comments/\(commentId)")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getComments:
      return .get
    case .postComments:
      return .post
    case .patchComment:
      return .patch
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    headers["Authorization"] = accessToken
    
    switch self {
    case .getComments:
      headers["Content-Type"] = "application/json"
    case .postComments:
      headers["Content-Type"] = "application/json"
    case .patchComment:
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
  
  var parameters: Parameters {
    var params = Parameters()

    switch self {
    case .getComments:
      break
    case let .postComments(_, content):
      params["content"] = content
    case let .patchComment(_, content):
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
    case .getComments:
      request = try URLEncoding.default.encode(request, with: nil)
    case .postComments:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .patchComment:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    }
    
    return request
  }
}

