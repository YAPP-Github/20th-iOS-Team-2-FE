//
//  AlbumDetailListViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/22.
//

import Foundation
import Alamofire
import Combine

class AlbumDetailListViewModel: ObservableObject {
  @Published var albumDetailList = [AlbumDetailElement]()
  @Published var type: String = ""
  @Published var isLoading: Bool = false // Loding
  @Published var pageInfo : Info? {
    didSet {
//      print("pageInfo: \(pageInfo!)")
    }
  }
  var albumId: Int = -1
  var kindType: String = ""
  private var subscription = Set<AnyCancellable>()    // disposeBag
  // 날짜별
  var refreshActionSubjectByDate = PassthroughSubject<(), Never>()
  var fetchMoreActionSubjectByDate = PassthroughSubject<(), Never>()
  
  // 유형별
  var refreshActionSubjectByKind = PassthroughSubject<(), Never>()
  var fetchMoreActionSubjectByKind = PassthroughSubject<(), Never>()

  var currentPage: Int = 0
  
  init(albumId: Int?, kindType: String?) {
    if let albumId = albumId { // 날짜별
      self.albumId = albumId

      fetchAlbumDetailByDate()
      
      refreshActionSubjectByDate.sink{ [weak self] _ in
        guard let self = self else { return }
        self.fetchAlbumDetailByDate()
      }.store(in: &subscription)
      
      fetchMoreActionSubjectByDate.sink{[weak self] _ in
        guard let self = self else { return }
        if !self.isLoading {
          self.fetchMoreByDate()
        }
      }.store(in: &subscription)
    }
    
    if let kindType = kindType { // 유형별
      self.kindType = kindType
      
      fetchAlbumDetailByKind()
      
      refreshActionSubjectByKind.sink{ [weak self] _ in
        guard let self = self else { return }
        self.fetchAlbumDetailByKind()
      }.store(in: &subscription)
      
      fetchMoreActionSubjectByKind.sink{[weak self] _ in
        guard let self = self else { return }
        if !self.isLoading {
          self.fetchMoreByKind()
        }
      }.store(in: &subscription)
    }
  }
    
  // 날짜별
  fileprivate func fetchAlbumDetailByDate() {
    self.isLoading = true
    
    AF.request(AlbumDetailManger.getAlbumDetailListByDate(albumId: albumId))
      .publishDecodable(type: AlbumDetailAPIResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: {[weak self] in
          self?.isLoading = false
          guard case .failure(let error) = $0 else { return }
          switch error.responseCode {
          case 400: // 요청 에러 발생했을 때
            break
          case 500: // 서버의 내부적 에러가 발생했을 때
            break
          default:
            break
          }
//          NSLog("Error : " + error.localizedDescription)
          self?.albumDetailList = [AlbumDetailElement]()
        },
        receiveValue: {[weak self] receivedValue in
//                    print("받은 값 : \(receivedValue)")
          self?.albumDetailList = receivedValue.results.elements
          self?.pageInfo = receivedValue.info
          self?.currentPage = 0
        }
      )
      .store(in: &subscription)   // disposed(by: disposeBag)
  }
  
  // 유형별
  fileprivate func fetchAlbumDetailByKind() {
    self.isLoading = true
    
    AF.request(AlbumDetailManger.getAlbumDetailListByKind(kind: kindType))
      .publishDecodable(type: AlbumDetailAPIResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: {[weak self] in
          self?.isLoading = false
          guard case .failure(let error) = $0 else { return }
          switch error.responseCode {
          case 400: // 요청 에러 발생했을 때
            break
          case 500: // 서버의 내부적 에러가 발생했을 때
            break
          default:
            break
          }
//          NSLog("Error : " + error.localizedDescription)
          self?.albumDetailList = [AlbumDetailElement]()
        },
        receiveValue: {[weak self] receivedValue in
          //          print("받은 값 : \(receivedValue)")
          self?.albumDetailList = receivedValue.results.elements
          self?.type = receivedValue.results.type!
          self?.pageInfo = receivedValue.info
          self?.currentPage = 0
        }
      )
      .store(in: &subscription)   // disposed(by: disposeBag)
  }
  
  // 날짜별 pagenation
  fileprivate func fetchMoreByDate() {
    if self.currentPage + 1 == pageInfo?.pageCount {
      print("Album Detail Date 페이지 정보가 없습니다.")
      return
    }

    self.isLoading = true
    self.currentPage += 1
    let pageToLoad = currentPage

    AF.request(AlbumDetailManger.getAlbumDetailListByDate(albumId: albumId, page: pageToLoad))
      .publishDecodable(type: AlbumDetailAPIResponse.self)
      .value()
      .sink(
        receiveCompletion: { completion in
          self.isLoading = false
        },
        receiveValue: { receivedValue in
//          print("받은 값 : \(receivedValue.results.albums.count)")
          self.albumDetailList += receivedValue.results.elements
          self.pageInfo = receivedValue.info
        }
      )
      .store(in: &subscription)
  }
  
  // 유형별 pagenation
  fileprivate func fetchMoreByKind() {
    if self.currentPage + 1 == pageInfo?.pageCount {
      print("Album Detail Kind 페이지 정보가 없습니다.")
      return
    }

    self.isLoading = true
    self.currentPage += 1
    let pageToLoad = currentPage

    AF.request(AlbumDetailManger.getAlbumDetailListByKind(kind: kindType, page: pageToLoad))
      .publishDecodable(type: AlbumDetailAPIResponse.self)
      .value()
      .sink(
        receiveCompletion: { completion in
          self.isLoading = false
        },
        receiveValue: { receivedValue in
//          print("받은 값 : \(receivedValue.results.albums.count)")
          self.albumDetailList += receivedValue.results.elements
          self.pageInfo = receivedValue.info
        }
      )
      .store(in: &subscription)
  }
  
  // 대표사진
  func putDelegate(albumId: Int, fileId: Int) {
    AF.request(AlbumDetailManger.putAlbumDelegate(albumId: albumId, fieldId: fileId))
      .publishDecodable(type: AlbumDefaulAPIResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          guard case .failure(let error) = completion else { return }
          NSLog("Error : " + error.localizedDescription)
        },
        receiveValue: { receivedValue in
          NSLog("받은 값 : \(receivedValue)")
        }
      )
      .store(in: &subscription)   // disposed(by: disposeBag)
  }
  
  // 파일 삭제
  func deleteFile(fileId: Int) {
    AF.request(AlbumDetailManger.deleteFile(fileId: fileId))
      .publishDecodable(type: AlbumDefaulAPIResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          guard case .failure(let error) = completion else { return }
          NSLog("Error : " + error.localizedDescription)
        },
        receiveValue: { receivedValue in
          NSLog("받은 값 : \(receivedValue)")
        }
      )
      .store(in: &subscription)   // disposed(by: disposeBag)
  }
}
