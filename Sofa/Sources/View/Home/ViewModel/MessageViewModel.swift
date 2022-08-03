//
//  MessageViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/08/04.
//

import Foundation
import Alamofire
import Combine

class MessageViewModel: ObservableObject{

  private var subscription = Set<AnyCancellable>() // disposeBag

  func postMessage(content: String) {
    AF.request(MessageManager.postMessage(content: content))
      .publishDecodable(type: MessageResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: {completion in
          guard case .failure(let error) = completion else { return }
          NSLog("Error : " + error.localizedDescription)
          print("MESSAGE POST 성공")
          
        },
        receiveValue: {receivedValue in
          NSLog("받은 값 : \(receivedValue)")
        }
      )
      .store(in: &subscription)
  }
  
}

