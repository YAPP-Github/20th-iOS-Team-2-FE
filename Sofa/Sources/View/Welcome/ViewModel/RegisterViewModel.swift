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
    AF.request(UserFamilyManager.registerUser(name: name, roleInFamily: roleInFamily, birthDay: birthDay, nickname: nickname))
      .publishDecodable(type: RegisterResponse.self)
      .value()
      .sink(
        receiveCompletion: { completion in
        },
        receiveValue: { receivedValue in
          self.registerResponse = receivedValue
        })
      .store(in: &subscription)
  }
}
