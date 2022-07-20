//
//  AlbumUploadViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/19.
//

import Foundation
import Alamofire
import Combine

class AlbumUploadViewModel: ObservableObject {
  @Published var uploadFiles = [String]()
  private var subscription = Set<AnyCancellable>()    // disposeBag
  
  init(images: [UIImage]) {
    print(#fileID, #function, #line, "")
    fetchUploadFiles(images: images) // 파일 업로드
  }
  
  // 서버에 파일 업로드 후, Link 받아오기
  fileprivate func fetchUploadFiles(images: [UIImage]) {
    print(#fileID, #function, #line, "")
    
    AF.upload(multipartFormData: { multipartFormData in
      for image in images {
        multipartFormData.append(image.pngData()!, withName: "files", fileName: "\(image.pngData()!).png", mimeType: "image/png")
      }
    }, with: UploadManager.postImages)
    .publishDecodable(type: UploadFilesAPIResponse.self)
    .value()
    .receive(on: DispatchQueue.main)
    .sink(
      receiveCompletion: {[weak self] in
        guard case .failure(let error) = $0 else { return }
        NSLog("Error : " + error.localizedDescription)
        self?.uploadFiles = [String]()
      },
      receiveValue: {[weak self] receivedValue in
        NSLog("받은 값 : \(receivedValue)")
        self?.uploadFiles = receivedValue.links
      }
    )
    .store(in: &subscription)   // disposed(by: disposeBag)
  }
}
