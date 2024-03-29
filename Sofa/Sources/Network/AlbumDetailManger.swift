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
  case patchAlbumTitle(albumId: Int, title: String)
  case patchAlbumDate(albumId: Int, date: String)
  case patchAlbumDetailDate(fieldId: Int, date: String)
  case putAlbumDelegate(albumId: Int, fieldId: Int)
  case postFavourite(fieldId: Int)
  case deleteAlbum(albumId: Int)
  case deleteFile(fileId: Int)
  
  var baseURL: URL {
    switch self {
    case let .getAlbumDetailListByDate(albumId, _, _):
      return URL(string: "\(APIConstants.url)/album/details/\(albumId)")!
    case .getAlbumDetailListByKind:
      return URL(string: "\(APIConstants.url)/album/details")!
    case let .patchAlbumTitle(albumId, _):
      return URL(string: "\(APIConstants.url)/album/\(albumId)")!
    case let .patchAlbumDate(albumId, _):
      return URL(string: "\(APIConstants.url)/album/\(albumId)/date")!
    case let .patchAlbumDetailDate(fieldId, _):
      return URL(string: "\(APIConstants.url)/files/\(fieldId)/date")!
    case let .putAlbumDelegate(albumId, _):
      return URL(string: "\(APIConstants.url)/album/\(albumId)/delegate")!
    case .postFavourite:
      return URL(string: "\(APIConstants.url)/album/favourite")!
    case let .deleteAlbum(albumId):
      return URL(string: "\(APIConstants.url)/album/\(albumId)")!
    case let .deleteFile(fileId):
      return URL(string: "\(APIConstants.url)/album/\(fileId)")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getAlbumDetailListByDate:
      return .get
    case .getAlbumDetailListByKind:
      return .get
    case .patchAlbumTitle:
      return .patch
    case .patchAlbumDate:
      return .patch
    case .patchAlbumDetailDate:
      return .patch
    case .putAlbumDelegate:
      return .put
    case .postFavourite:
      return .post
    case .deleteAlbum:
      return .delete
    case .deleteFile:
      return .delete
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    headers["Authorization"] = "Bearer \(Constant.accessToken ?? "")"

    switch self {
    case .getAlbumDetailListByDate:
      headers["accept"] = "application/json"
    case .getAlbumDetailListByKind:
      headers["accept"] = "application/json"
    case .patchAlbumTitle:
      headers["accept"] = "application/json"
      headers["Content-Type"] = "application/json"
    case .patchAlbumDate:
      headers["accept"] = "application/json"
      headers["Content-Type"] = "application/json"
    case .patchAlbumDetailDate:
      headers["accept"] = "application/json"
      headers["Content-Type"] = "application/json"
    case .putAlbumDelegate:
      headers["accept"] = "application/json"
      headers["Content-Type"] = "application/json"
    case .postFavourite:
      headers["accept"] = "application/json"
    case .deleteAlbum:
      headers["accept"] = "application/json"
      headers["Content-Type"] = "application/json"
    case .deleteFile:
      headers["accept"] = "application/json"
      headers["Content-Type"] = "application/json"
    }
    return headers
  }
  
  var parameters: Parameters {
    var params = Parameters()

    switch self {
    case .getAlbumDetailListByDate:
      break
    case let .getAlbumDetailListByKind(kind, page, size):
      params["kind"] = kind
      params["page"] = page
      params["size"] = size
    case let .patchAlbumTitle(_, title):
      params["albumName"] = title
    case let .patchAlbumDate(_, date):
      params["date"] = date
    case let .patchAlbumDetailDate(_, date):
      params["date"] = date
    case let .putAlbumDelegate(_, fieldId):
      params["fileId"] = fieldId
    case let .postFavourite(fieldId):
      params["fileId"] = fieldId
    default:
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
    case .getAlbumDetailListByDate:
      request = try URLEncoding.default.encode(request, with: nil)
    case .getAlbumDetailListByKind:
      request = try URLEncoding.default.encode(request, with: parameters)
    case .patchAlbumTitle:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .patchAlbumDate:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .patchAlbumDetailDate:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .putAlbumDelegate:
      request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
    case .postFavourite:
      request = try URLEncoding.default.encode(request, with: parameters)
    case .deleteAlbum:
      request = try URLEncoding.default.encode(request, with: nil)
    case .deleteFile:
      request = try URLEncoding.default.encode(request, with: nil)
    }

    return request
  }
}

