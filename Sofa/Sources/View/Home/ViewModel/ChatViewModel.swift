//
//  ChatViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/03.
//

import Foundation
import Combine

class MemberViewModel: ObservableObject{
  
  //MARK: Properties
  var subscription = Set<AnyCancellable>()
  
  @Published var members = [Member]()
  
  var baseUrl = ""
  
  init(){
    fetchMembers()
  }
  
  func fetchMembers(){
    
    guard let path = Bundle.main.path(forResource: "ChatInfoMock", ofType: "json")
    else {
      fatalError("Couldn't find file in main bundle.")
    }
    
    guard let jsonString = try? String(contentsOfFile: path) else {
      return
    }
    
    
    if let data = jsonString.data(using: .utf8){
      Just(data)
        .decode(type: familyList.self, decoder: JSONDecoder())
        .map{ $0.members }
        .sink(receiveCompletion: { completion in
//          print("데이터스트림 완료")
          
        }, receiveValue: { receivedValue in
//          print("받은 값: \(receivedValue.count)")
          self.members = receivedValue
        }).store(in: &subscription)
    }
    
  }
}

