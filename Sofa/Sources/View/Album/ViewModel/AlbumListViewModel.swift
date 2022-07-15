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
  @Published var isLoading: Bool = false             // Loding
  private var cancellables = Set<AnyCancellable>()    // disposeBag
  
  init() {
    print(#fileID, #function, #line, "")
    fetchAlbumByDate() // 날짜별
  }

  // 날짜별
  fileprivate func fetchAlbumByDate() {
    self.isLoading = true
    AF.request(AlbumManager.getAlbumListByDate())
      .publishDecodable(type: AlbumDateAPIResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .map { $0.albums }
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
//          print("받은 값 : \(receivedValue)")
          self?.albumDateList = receivedValue
        }
      )
      .store(in: &cancellables)   // disposed(by: disposeBag)
  }
}
