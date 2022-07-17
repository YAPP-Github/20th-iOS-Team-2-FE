//
//  AlbumManager.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/14.
//

import Foundation
import Alamofire
import Combine

enum AlbumManager: URLRequestConvertible {
  
  case getAlbumListByDate(page: Int = 1, results: Int = 20)
  case getAlbumListByKind

  var baseURL: URL {
    switch self {
    case .getAlbumListByDate:
      return URL(string: "\(APIConstants.url)/album")!
    case .getAlbumListByKind:
      return URL(string: "\(APIConstants.url)/album")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getAlbumListByDate:
      return .get
    case .getAlbumListByKind:
      return .get
    }
  }

  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    headers["Authorization"] = accessToken

    switch self {
    case .getAlbumListByDate:
      return headers
    case .getAlbumListByKind:
      return headers
    }
  }
  
  var parameters: Parameters {
    var params = Parameters()

    switch self {
    case .getAlbumListByDate:
      //      params["page"] = page
      //      params["results"] = results
      params["type"] = "date"
      return params
    case .getAlbumListByKind:
      params["type"] = "kind"
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

