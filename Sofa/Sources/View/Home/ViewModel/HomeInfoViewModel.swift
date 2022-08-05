//
//  HomeInfoViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/24.
//

import Foundation
import Alamofire
import Combine

class HomeInfoViewModel: ObservableObject{
  
  @Published var events = [Event]()
  @Published var hometitle: String = ""
  
  private var cancellables = Set<AnyCancellable>()

  init(){
    print(#fileID, #function, #line, "")
    fetchEvents()
  }
  
  func fetchEvents(){
    
    AF.request(HomeInfoManager.getHomeInfo)
      .publishDecodable(type: HomeInfo.self)
      .value()
//      .print()
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
//              print(receivedValue.status!)
//              print(receivedValue.detail!)
              print(receivedValue)
              break
            case 500: // 서버의 내부적 에러가 발생했을 때
              print(receivedValue)
              break
            default:
              print(receivedValue)
              break
            }
          }else{ // Success
            print("HomeInfo events 받은 값: \(receivedValue.events?.count ?? 0)")
            self?.events = receivedValue.events!
            self?.hometitle = receivedValue.familyName!
          }
        }
      )
      .store(in: &cancellables)

    
  }
}

