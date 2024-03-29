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
  
  case getAlbumListByDate(page: Int = 0, size: Int = 10)
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
    headers["Authorization"] = "Bearer \(Constant.accessToken ?? "")"

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
    case let .getAlbumListByDate(page, size):
      params["type"] = "date"
      params["page"] = page
      params["size"] = size
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

