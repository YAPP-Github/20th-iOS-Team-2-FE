//
//  AlbumDetailManger.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/22.
//

import Foundation
import Alamofire
import Combine

enum AlbumDetailManger: URLRequestConvertible {
  
  case getAlbumDetailListByDate(albumId: Int, page: Int = 0, size: Int = 10)
  case getAlbumDetailListByKind(kind: String, page: Int = 0, size: Int = 10)
  
  var baseURL: URL {
    switch self {
    case let .getAlbumDetailListByDate(albumId, _, _):
      return URL(string: "\(APIConstants.url)/album/details/\(albumId)")!
    case .getAlbumDetailListByKind:
      return URL(string: "\(APIConstants.url)/album")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getAlbumDetailListByDate:
      return .get
    case .getAlbumDetailListByKind:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    headers["Authorization"] = accessToken
    
    switch self {
    case .getAlbumDetailListByDate:
      headers["accept"] = "application/json"
    case .getAlbumDetailListByKind:
      headers["accept"] = "application/json"
    }
    return headers
  }
  
  var parameters: Parameters {
    var params = Parameters()

    switch self {
    case .getAlbumDetailListByDate:
      break
    case let .getAlbumDetailListByKind(kind, _, _):
      params["kind"] = kind
    }
    return params
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

