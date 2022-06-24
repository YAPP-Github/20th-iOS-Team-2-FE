//
//  EventViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/24.
//

import Foundation
import Combine

class EventViewModel: ObservableObject{
  
  //MARK: Properties
  var subscription = Set<AnyCancellable>()
  
  @Published var events = [Event]()
  
  var baseUrl = ""
  
  init(){
    print(#fileID, #function, #line, "")
    fetchEvents()
  }
  
  func fetchEvents(){
    print(#fileID, #function, #line, "")
    
    guard let path = Bundle.main.path(forResource: "HomeInfoMock", ofType: "json")
    else {
      fatalError("Couldn't find file in main bundle.")
    }
    
    guard let jsonString = try? String(contentsOfFile: path) else {
      return
    }
    
    if let data = jsonString.data(using: .utf8){
      Just(data)
        .decode(type: HomeInfo.self, decoder: JSONDecoder())
        .map{ $0.events }
        .sink(receiveCompletion: { completion in
//          print("데이터스트림 완료")
          
        }, receiveValue: { receivedValue in
//          print("받은 값: \(receivedValue.count)")
          self.events = receivedValue
        }).store(in: &subscription)
    }
    
  }
}

