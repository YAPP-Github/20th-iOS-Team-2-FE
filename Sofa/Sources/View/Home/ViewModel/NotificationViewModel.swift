//
//  NotificationViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/10.
//

import Foundation
import Combine

class NotificationViewModel: ObservableObject{
  
  //MARK: Properties
  var subscription = Set<AnyCancellable>()
  
  @Published var notification = [Notification]()
  
  var baseUrl = ""
  
  init(){
    fetchNotification()
  }
  
  func fetchNotification(){
    
    guard let path = Bundle.main.path(forResource: "NotificationMock", ofType: "json")
    else {
      fatalError("Couldn't find file in main bundle.")
    }
    
    guard let jsonString = try? String(contentsOfFile: path) else {
      return
    }
    
    
    if let data = jsonString.data(using: .utf8){
      Just(data)
        .decode(type: Notifications.self, decoder: JSONDecoder())
        .map{ $0.notifications }
        .sink(receiveCompletion: { completion in
//          print("데이터스트림 완료")
          
        }, receiveValue: { receivedValue in
//          print("받은 값: \(receivedValue.count)")
          self.notification = receivedValue
        }).store(in: &subscription)
    }
    
    
  }
}

