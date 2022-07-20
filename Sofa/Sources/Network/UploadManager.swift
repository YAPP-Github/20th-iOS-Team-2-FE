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
  case postPhotos(date: String, links: [String])
  case postRecording(date: String, title: String, links: [String])

  var baseURL: URL {
    switch self {
    case .postFiles:
      return URL(string: "\(APIConstants.url)/files")!
    case .postPhotos:
      return URL(string: "\(APIConstants.url)/album/photos")!
    case .postRecording:
      return URL(string: "\(APIConstants.url)/album/recordings")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .postFiles:
      return .post
    case .postPhotos:
      return .post
    case .postRecording:
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
    case .postPhotos:
      headers["Content-Type"] = "application/json"
    case .postRecording:
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
  
  var parameters: Parameters {
    var params = Parameters()
    
    switch self {
    case .postFiles:
      break
    case let .postPhotos(date, links):
      params["date"] = date
      params["links"] = links
    case let .postRecording(date: date, title: title, links: links):
      params["date"] = date
      params["title"] = title
      params["links"] = links
    }
    return params
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    switch self {
    case .postFiles:
      request = try URLEncoding.default.encode(request, with: nil)
    case .postPhotos:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .postRecording:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    }
    
    return request
  }
}

