//
//  RegisterViewModel.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/22.
//

import Foundation
import Combine
import Alamofire

class RegisterViewModel: ObservableObject {
  
  var subscription = Set<AnyCancellable>()
  
  @Published var registerResponse: RegisterResponse
  
  init() {
    registerResponse = RegisterResponse(timestamp: "", status: 0, error: "", path: "", detail: "")
    print(#fileID, #function, #line, "")
  }
  
  func register(name: String, roleInFamily: String, birthDay: String, nickname: String) {
    AF.request(RegisterManager.registerUser(name: name, roleInFamily: roleInFamily, birthDay: birthDay, nickname: nickname))
      .publishDecodable(type: RegisterResponse.self)
      .value()
      .receive(on: DispatchQueue.main)
      .map { $0 }
      .sink(
        receiveCompletion: {[weak self] in
          guard case .failure(let error) = $0 else { return }
          switch error.responseCode {
          case 200:
            print("Success")
          case 400: // 요청 에러 발생했을 때
            break
          case 500: // 서버의 내부적 에러가 발생했을 때
            break
          default:
            break
          }
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
            self?.registerResponse = receivedValue
          }
        }
      )
      .store(in: &subscription)
  }
}
