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
  @Published var detailUser: DetailUser
  
  init() {
    registerResponse = RegisterResponse(timestamp: "", status: 0, error: "", path: "", detail: "")
    simpleUser = SimpleUser(userId: 0, nickname: "", name: "", roleInfamily: "", imageLink: "")
    detailUser = DetailUser(nickname: "", name: "", roleInFamily: "", birth: "", imageLink: "")
    print(#fileID, #function, #line, "")
    getUserSimple()
    getUserDetail()
  }
  
  func getUserSimple() { // '설정'뷰의 유저 정보 불러오기
    print(#fileID, #function, #line, "")
    AF.request(RegisterManager.getUserSimple)
      .publishDecodable(type: SimpleUser.self)
      .value()
      .sink(
        receiveCompletion: { completion in
        },
        receiveValue: { receivedValue in
          self.simpleUser = receivedValue
        })
      .store(in: &subscription)
  }
  
  func getUserDetail() {  // '프로필 설정'뷰의 유저 정보 불러오기
    print(#fileID, #function, #line, "")
    AF.request(RegisterManager.getUserDetail)
      .publishDecodable(type: DetailUser.self)
      .value()
      .sink(
        receiveCompletion: { completion in
        },
        receiveValue: { receivedValue in
          self.detailUser = receivedValue
        })
      .store(in: &subscription)
  }
}
