//
//  ChatScreenViewModel.swift
//  Sofa
//
//  Created by 양유진 on 2022/08/02.
//

import Foundation
import SwiftUI
import Combine


final class ChatScreenViewModel: ObservableObject {
  
  private var websocketTask: URLSessionWebSocketTask?
  
  @Published private(set) var messages: String = ""
  
  func connect() {
    guard let url = URL(string: "ws://3.34.94.220:8085/home/1/1") else {
      print("Error: can not create URL")
      return
    }
    var request = URLRequest(url: url)
    request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q", forHTTPHeaderField: "Authorization")

    websocketTask = URLSession.shared.webSocketTask(with: request)
    websocketTask?.resume()
    receiveMessage()
    print("connect!")
  }
  
  func disconnect() {
    websocketTask?.cancel(with: .normalClosure, reason: nil)
    print("disconnect!")
  }
 
  func receiveMessage() {
    websocketTask?.receive { result in
      switch result {
      case .failure(let error):
        print("Error in receiving message: \(error)")
      case .success(let message):
        switch message {
        case .string(let text):
          print("Received string: \(text)")
        case .data(let data):
          print("Received data: \(data)")
        }
        self.receiveMessage()
      }
    }
  }
  
  deinit {
    disconnect()
  }
}

