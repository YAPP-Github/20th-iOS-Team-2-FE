//
//  SettingViewModel.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/30.
//

import Foundation
import Combine
import Alamofire

class SettingViewModel: ObservableObject {
  
  var subscription = Set<AnyCancellable>()
  
  @Published var registerResponse: RegisterResponse
  @Published var simpleUser: SimpleUser
  
  init() {
    registerResponse = RegisterResponse(timestamp: "", status: 0, error: "", path: "", detail: "")
    simpleUser = SimpleUser(userId: 0, nickname: "", name: "", roleInfamily: "", imageLink: "")
    print(#fileID, #function, #line, "")
    getUserSimple()
  }
  
  func register(name: String, roleInFamily: String, birthDay: String, nickname: String) {
    print("UserVM: register() called")
    AF.request(RegisterManager.getUserSimple)
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
    
//    AuthAPIService.register(name: name, email: email, password: password)
//      .sink{ (completion: Subscribers.Completion<AFError>) in
//        print("UserVM completion: \(completion)")
//      } receiveValue: { (receivedUser: UserData) in
//        self.loggedInUser = receivedUser
//      }.store(in: &subscription)
  
  
  func getUserSimple() {
    print(#fileID, #function, #line, "")
    //기본 세션
    AF.request(RegisterManager.getUserSimple)
      .publishDecodable(type: SimpleUser.self) //파싱
      .value()
      .sink(
        receiveCompletion: { completion in //구독을 통해 이벤트 받음
        print("데이터스트림 완료 ")
      },
        receiveValue: { receivedValue in
        print("받은 값: \(receivedValue.roleInfamily)")
          print("받은 값: \(receivedValue.nickname)")
          print("글자수: \(receivedValue.roleInfamily?.count)")
        self.simpleUser = receivedValue //정제된 데이터를 넣음
      }).store(in: &subscription) //메모리에서 날려줌
  }
}

