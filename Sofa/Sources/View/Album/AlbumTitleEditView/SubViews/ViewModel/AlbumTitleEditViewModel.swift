//
//  AlbumTitleEditViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/23.
//

import Foundation
import Alamofire
import Combine

class AlbumTitleEditViewModel: ObservableObject {
  private var subscription = Set<AnyCancellable>()    // disposeBag
  
  // 앨범 제목 수정
  func patchAlbumTitle(albumId: Int, title: String) {
    AF.request(AlbumDetailManger.patchAlbumTitle(albumId: albumId, title: title))
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
