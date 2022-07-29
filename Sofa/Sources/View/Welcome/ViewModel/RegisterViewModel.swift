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
    print("UserVM: register() called")
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
    
//    AuthAPIService.register(name: name, email: email, password: password)
//      .sink{ (completion: Subscribers.Completion<AFError>) in
//        print("UserVM completion: \(completion)")
//      } receiveValue: { (receivedUser: UserData) in
//        self.loggedInUser = receivedUser
//      }.store(in: &subscription)
  
  
//  func fetchRandomUsers() {
//    print(#fileID, #function, #line, "")
//    //기본 세션
//    AF.request(APIConstants.url)
//      .publishDecodable(type: RegisterUser.self) //파싱
//      .compactMap{ $0.value } //옵셔널제거, 언랩핑
//      //.map{ $0.results } //result만 가지고 옴
//      .sink(receiveCompletion: { completion in //구독을 통해 이벤트 받음
//        print("데이터스트림 완료 ")
//      }, receiveValue: { receivedValue in
//        //print("받은 값: \(receivedValue.count)")
//        self.registerUsers = receivedValue //정제된 데이터를 넣음
//      }).store(in: &subscription) //메모리에서 날려줌
//  }
}

