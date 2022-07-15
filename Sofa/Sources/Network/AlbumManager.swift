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

  var baseURL: URL {
    switch self {
    case .getAlbumListByDate:
      return URL(string: "\(APIConstants.url)/album")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getAlbumListByDate:
      return .get
    }
  }

  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzpudWxsIiwiaWF0IjoxNjU2OTQ4NDUyLCJleHAiOjE2NTY5NTIwNTJ9.z_D9IzZDNhqKpXvEqc-8H_RjANDra0MOx044zpw8YNU"
    headers["Authorization"] = accessToken

    switch self {
    case .getAlbumListByDate:
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

