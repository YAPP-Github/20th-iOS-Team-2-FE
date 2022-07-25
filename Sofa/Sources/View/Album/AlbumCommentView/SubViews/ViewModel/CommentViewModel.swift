//
//  CommentViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/10.
//

import Foundation
import Alamofire
import Combine

class CommentViewModel: ObservableObject{
  //MARK: Properties
  @Published var comments = [Comment]()
  
  private var subscription = Set<AnyCancellable>() // disposeBag
  var filedId: Int
  
  init(filedId: Int) {
    self.filedId = filedId
    
    fetchComments() // 댓글 조회
  }
  
  // 댓글 조회
  func fetchComments() {
    AF.request(CommentManger.getComments(fileId: self.filedId))
      .publishDecodable(type: CommensAPIResponse.self)
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
          // NSLog("Error : " + error.localizedDescription)
          self?.comments = [Comment]()
        },
        receiveValue: {[weak self] receivedValue in
          //  NSLog("받은 값 : \(receivedValue)")
          self?.comments = receivedValue.comments
        }
      )
      .store(in: &subscription)   // disposed(by: disposeBag)
  }
}

