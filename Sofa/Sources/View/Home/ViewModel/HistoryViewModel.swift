//
//  HistoryViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/07.
//

import Foundation
import Combine
import Alamofire

class HistoryViewModel: ObservableObject{
  
  @Published var info: HistoryInfo = HistoryInfo(nickname: "희동이", roleInFamily: "엄마", profileLink: "", count: 6, history: [])
  @Published var history = [History]()
  @Published var isLoading: Bool = false
  
  
  init(){
    print(#fileID, #function, #line, "")
  }
  
  private var subscription = Set<AnyCancellable>()
  
  func fetchHistory(userId: Int){
    
    AF.request(HistoryManager.getHistory(userId: userId))
      .publishDecodable(type: HistoryInfo.self)
      .value()
      .print()
      .receive(on: DispatchQueue.main)
      .map { $0 }
      .sink(
        receiveCompletion: {[weak self] in
          guard case .failure(let error) = $0 else { return }
          NSLog("Error : " + error.localizedDescription)
        },
        receiveValue: {[weak self] receivedValue in
          if receivedValue.status != nil{
            switch receivedValue.status {
            case 400: // 요청 에러 발생했을 때
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            case 500: // 서버의 내부적 에러가 발생했을 때
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            default:
              print(receivedValue.status!)
              print(receivedValue.detail!)
              break
            }
          }else{ // Success
            print("History 받은 값: \(receivedValue.history?.count ?? 0)")
            self?.info = HistoryInfo(timestamp: "", status: 0, error: "", detail: "", path: "", nickname: receivedValue.nickname ?? "", roleInFamily: receivedValue.roleInFamily ?? "", profileLink: receivedValue.profileLink ?? "", count: receivedValue.count ?? 0, history: [])
            self?.history = Array((receivedValue.history?.reversed())!)
            self?.isLoading = true
          }
        }
      )
      .store(in: &subscription)

    
  }
}

