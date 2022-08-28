//
//  AlbumDetailCellViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/08/28.
//

import Foundation
import Alamofire
import Combine

class AlbumDetailCellViewModel: ObservableObject {
  
  private var subscription = Set<AnyCancellable>()    // disposeBag

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
