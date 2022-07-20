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
  
  // 서버에 파일 업로드 후, Link 받아오기
  func fetchUploadFiles(date: String, images: [UIImage]?, title: String?, audio: URL?) {
    print(#fileID, #function, #line, "")
    
    AF.upload(multipartFormData: { multipartFormData in
      if let images = images { // 사진
        for image in images {
          multipartFormData.append(image.jpegData(compressionQuality: 1)!, withName: "files", fileName: "\(image.pngData()!).jpeg", mimeType: "image/jpeg")
        }
      }
      
      if let audio = audio { // 오디오
        let fileName = audio.lastPathComponent
        guard let audioFile: Data = try? Data(contentsOf: audio) else { return }
        multipartFormData.append(audioFile, withName: "files", fileName: fileName, mimeType: "audio/m4a")
      }
    }, with: UploadManager.postFiles)
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
        self?.uploadFiles = receivedValue.links!
        guard let links = receivedValue.links else {
          NSLog("links를 받아오지 못했습니다")
          return
        }
        
        if images != nil { // 사진
          self?.postUploadPhoto(date: date, links: links)
        }
      }
    )
    .store(in: &subscription)   // disposed(by: disposeBag)
  }
  
  fileprivate func postUploadPhoto(date: String, links: [String]) {
    print(#fileID, #function, #line, "")
    AF.request(UploadManager.postPhotos(date: date, links: links))
      .publishDecodable(type: UploadFilesAPIResponse.self)
      .value()
      .sink(
        receiveCompletion: { completion in
          // guard case .failure(let error) = completion else { return }
          // NSLog("Error : " + error.localizedDescription)
        },
        receiveValue: { receivedValue in
          // NSLog("받은 값 : \(receivedValue)")
        }
      )
      .store(in: &subscription)
  }
}
