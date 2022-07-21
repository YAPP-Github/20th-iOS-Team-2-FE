//
//  AlbumListViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/14.
//

import Foundation
import Alamofire
import Combine

class AlbumListViewModel: ObservableObject {
  @Published var albumDateList = [AlbumDate]()
  @Published var albumKindList = [AlbumKind]()
  @Published var isLoading: Bool = false // Loding
  @Published var pageInfo : Info? {
    didSet {
//      print("pageInfo: \(pageInfo!)")
    }
  }
  private var subscription = Set<AnyCancellable>()    // disposeBag
  var refreshActionSubject = PassthroughSubject<(), Never>()
  var fetchMoreActionSubject = PassthroughSubject<(), Never>()
  var currentPage: Int = 0
  
  init() {
//    print(#fileID, #function, #line, "")
    fetchAlbumByDate() // 날짜별
    fetchAlbumByType() // 유형별
    
    refreshActionSubject.sink{ [weak self] _ in
      guard let self = self else { return }
      self.fetchAlbumByDate()
    }.store(in: &subscription)
    
    fetchMoreActionSubject.sink{[weak self] _ in
      guard let self = self else { return }
      if !self.isLoading {
        self.fetchMore()
      }
    }.store(in: &subscription)
  }
  
  // 날짜별
  fileprivate func fetchAlbumByDate() {
    self.isLoading = true
    AF.request(AlbumManager.getAlbumListByDate())
      .publishDecodable(type: AlbumDateAPIResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .map { $0 }
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
          self?.albumDateList = [AlbumDate]()
        },
        receiveValue: {[weak self] receivedValue in
//                    print("받은 값 : \(receivedValue)")
          self?.albumDateList = receivedValue.results.albums
          self?.pageInfo = receivedValue.info
          self?.currentPage = 0
        }
      )
      .store(in: &subscription)   // disposed(by: disposeBag)
  }
  
  // 유형별
  fileprivate func fetchAlbumByType() {
    AF.request(AlbumManager.getAlbumListByKind)
      .publishDecodable(type: AlbumTypeAPIResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: {[weak self] in
          guard case .failure(let error) = $0 else { return }
          switch error.responseCode {
          case 400: // 요청 에러 발생했을 때
            break
          case 500: // 서버의 내부적 에러가 발생했을 때
            break
          default:
            break
          }
          NSLog("Error : " + error.localizedDescription)
          self?.albumKindList = [AlbumKind]()
        },
        receiveValue: {[weak self] receivedValue in
          //          print("받은 값 : \(receivedValue)")
          self?.albumKindList.append(receivedValue.favourite)
          self?.albumKindList.append(receivedValue.photo)
          self?.albumKindList.append(receivedValue.recording)
        }
      )
      .store(in: &subscription)   // disposed(by: disposeBag)
  }
  
  // pagenation
  fileprivate func fetchMore() {
    if self.currentPage == pageInfo?.pageCount {
      print("페이지 정보가 없습니다.")
      return
    }
    
    self.isLoading = true
    self.currentPage += 1
    let pageToLoad = currentPage
    
    AF.request(AlbumManager.getAlbumListByDate(page: pageToLoad))
      .publishDecodable(type: AlbumDateAPIResponse.self)
      .value()
      .sink(
        receiveCompletion: { completion in
          self.isLoading = false
        },
        receiveValue: { receivedValue in
//          print("받은 값 : \(receivedValue.results.albums.count)")
          self.albumDateList += receivedValue.results.albums
          self.pageInfo = receivedValue.info
        }
      )
      .store(in: &subscription)
  }
}
