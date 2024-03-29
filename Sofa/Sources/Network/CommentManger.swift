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
  case deleteComment(commentId: Int)
  
  var baseURL: URL {
    switch self {
    case let .getComments(fileId):
      return URL(string: "\(APIConstants.url)/album/\(fileId)/comments")!
    case let .postComments(fileId, _):
      return URL(string: "\(APIConstants.url)/album/\(fileId)/comments")!
    case let .patchComment(commentId, _):
      return URL(string: "\(APIConstants.url)/album/comments/\(commentId)")!
    case let .deleteComment(commentId):
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
    case .deleteComment:
      return .delete
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    headers["Authorization"] = "Bearer \(Constant.accessToken ?? "")"

    switch self {
    case .getComments:
      headers["Content-Type"] = "application/json"
    case .postComments:
      headers["Content-Type"] = "application/json"
    case .patchComment:
      headers["Content-Type"] = "application/json"
    case .deleteComment:
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
    case .deleteComment:
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
    case .getComments:
      request = try URLEncoding.default.encode(request, with: nil)
    case .postComments:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .patchComment:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .deleteComment:
      request = try URLEncoding.default.encode(request, with: nil)
    }
    
    return request
  }
}

