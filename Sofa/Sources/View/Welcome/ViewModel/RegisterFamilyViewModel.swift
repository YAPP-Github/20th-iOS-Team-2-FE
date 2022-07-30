//
//  RegisterFamilyViewModel.swift
//  Sofa
//
//  Created by 임주민 on 2022/07/22.
//

import Foundation
import Combine
import Alamofire

class RegisterFamilyViewModel: ObservableObject {
  
  var subscription = Set<AnyCancellable>()

  @Published var familyID: FamilyID
  
  init() {
    familyID = FamilyID(familyId: 0)
    print(#fileID, #function, #line, "")
  }
  
  // 가족 등록 post -> familyID 받는 함수
  func registerFamily(familyName: String, familyMotto: String) {
    AF.request(UserFamilyManager.registerFamily(familyName: familyName, familyMotto: familyMotto))
      .publishDecodable(type: FamilyID.self)
      .value()
      .receive(on: DispatchQueue.main)
      .map { $0 }
      .sink(
        receiveCompletion: { completion in
        },
        receiveValue: { receivedValue in
          self.familyID = receivedValue
          //print(receivedValue.familyId)
        })
      .store(in: &subscription)
  }
}
