//
//  HistoryViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/07.
//

import Foundation
import Combine

class HistoryViewModel: ObservableObject{
  
  //MARK: Properties
  var subscription = Set<AnyCancellable>()
  
  @Published var info: HistoryInfo
  @Published var history = [History]()
  
  var baseUrl = ""
  
  init(){
    info = HistoryInfo(nickname: "희동이", roleInFamily: "엄마", profileLink: "", count: 6, history: [])
    fetchHistory()
  }
  
  func fetchHistory(){
    
    guard let path = Bundle.main.path(forResource: "HistoryMock", ofType: "json")
    else {
      fatalError("Couldn't find file in main bundle.")
    }
    
    guard let jsonString = try? String(contentsOfFile: path) else {
      return
    }
    
    if let infodata = jsonString.data(using: .utf8){
      Just(infodata)
        .decode(type: HistoryInfo.self, decoder: JSONDecoder())
        .map{ $0 }
        .sink(receiveCompletion: { completion in
//          print("데이터스트림 완료")
          
        }, receiveValue: { receivedValue in
//          print("받은 값: \(receivedValue.count)")
          self.info = receivedValue
        }).store(in: &subscription)
    }
    
    if let data = jsonString.data(using: .utf8){
      Just(data)
        .decode(type: HistoryInfo.self, decoder: JSONDecoder())
        .map{ $0.history }
        .sink(receiveCompletion: { completion in
//          print("데이터스트림 완료")
          
        }, receiveValue: { receivedValue in
//          print("받은 값: \(receivedValue.count)")
          self.history = receivedValue
        }).store(in: &subscription)
    }
    
    
  }
}

