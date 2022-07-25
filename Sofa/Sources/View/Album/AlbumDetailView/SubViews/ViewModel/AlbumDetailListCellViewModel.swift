//
//  AlbumDetailListCellViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/24.
//

import Foundation
import Alamofire
import Combine

class AlbumDetailListCellViewModel: ObservableObject {
  @Published var isFavourite: Bool
  
  private var subscription = Set<AnyCancellable>()    // disposeBag
  var fileId: Int = -1

  init(fileId: Int, isFavourite: Bool) {
    self.isFavourite = isFavourite
    self.fileId = fileId
  }
    
  // 즐겨찾기
  func fetchAlbumDetailByDate() {
    AF.request(AlbumDetailManger.postFavourite(fieldId: self.fileId))
      .publishDecodable(type: AlbumFavouriteAPIResponse.self)
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
          self?.isFavourite = false
        },
        receiveValue: {[weak self] receivedValue in
//                    print("받은 값 : \(receivedValue)")
          self?.isFavourite = receivedValue.result
        }
      )
      .store(in: &subscription)   // disposed(by: disposeBag)
  }
}
