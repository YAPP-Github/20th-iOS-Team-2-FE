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
  @Published var ChatData: OriginalChatResponse = OriginalChatResponse(timestamp: "", status: nil, detail: "")
  @ObservedObject var ChatShared = Chat.shared
  
  var subscription = Set<AnyCancellable>()
  
  func connect() {
//    guard let url = URL(string: "ws://3.34.94.220:8085/home/\(Constant.userId ?? -1)") else {
//      print("Error: can not create URL")
//      return
//    }
    guard let url = URL(string: "ws://3.34.94.220:8085/home/\(Constant.userId ?? 0)") else {
      print("Error: can not create URL")
      return
    }
    var request = URLRequest(url: url)
//    request.addValue(Constant.accessToken ?? "", forHTTPHeaderField: "Authorization")
//    request.addValue("                                                                                                                                                                                                                                     eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q", forHTTPHeaderField: "Authorization")
    
    request.addValue("Bearer \(Constant.accessToken ?? "")", forHTTPHeaderField: "Authorization")
    print(Constant.accessToken!)
    websocketTask = URLSession.shared.webSocketTask(with: request)
    websocketTask?.resume()
    receiveMessage()
    print("connect!")
    ping()
  }
  
  func disconnect() {
    websocketTask?.cancel(with: .normalClosure, reason: nil)
    print("disconnect!")
  }
 
  func receiveMessage() {
    print("receiveMessage() called")
    websocketTask?.receive { [self] result in
      switch result {
      case .failure(let error):
          print("Error in receiving message: \(error)")
          let code = (error as NSError).code
          if code == 60 || code == 57 || code == 54 {
              // deal with error
            print(code)
            print(error)
          }
      case .success(let message):
        switch message {
        case .string(let text):
          print("Received string: \(text)")
          if ChatShared.first == true{ // 가장 처음
            if let chatData = text.data(using: .utf8){
              Just(chatData)
                .decode(type: OriginalChatResponse.self, decoder: JSONDecoder())
                .map{ $0.members }
                .sink(receiveCompletion: { completion in
//                  print("데이터스트림 완료")

                }, receiveValue: { receivedValue in
                  print("ChatScreen 받은 값: \(receivedValue?.count ?? 0)")
                  var sortedReceivedValue = receivedValue
                  sortedReceivedValue = sortedReceivedValue?.sorted(by: {$0.updatedAt > $1.updatedAt})
                  print(receivedValue)
                  print(sortedReceivedValue)
                  DispatchQueue.main.async {
                    self.ChatShared.members = sortedReceivedValue ?? []
                    self.ChatShared.first = false
                    for i in (0...sortedReceivedValue!.count-1){
                      self.ChatShared.indexs[sortedReceivedValue![i].userId] = i
                    }
                  }
                  
                }).store(in: &subscription)
            }
          }else{
            // 처음이 아니라면 싱글톤 객체에 추가됨
            print("GET NEW DATA")
//            print("firstConnected: \(ChatShared.first)")
            if let chatData = text.data(using: .utf8){
              Just(chatData)
                .decode(type: NewChatResponse.self, decoder: JSONDecoder())
                .map{ $0 }
                .sink(receiveCompletion: { completion in
//                  print("데이터스트림 완료")

                }, receiveValue: { receivedValue in
                  var idx = -1
                  if receivedValue.userId != nil{
                    idx = self.ChatShared.indexs[receivedValue.userId!]!
                  }
                  if idx != -1{
                    print("NEW CHAT RESPONSE")
//                    print("Received string: \(text)")
                    DispatchQueue.main.async {
                      if receivedValue.emoji == nil{
                        self.ChatShared.members[idx].content = receivedValue.content
                      }else if receivedValue.content == nil {
                        self.ChatShared.members[idx].emoji = receivedValue.emoji ?? 0
                      }
                      self.ChatShared.members[idx].updatedAt = "방금전"
                      self.ChatShared.moveIndex = idx
                      self.ChatShared.getData = true
                    }
                    
                  }
                }).store(in: &subscription)
            }
          }
          
        case .data(let data):
          print("Received data: \(data)")
        @unknown default:
          print("@unknown default")
        }
        self.receiveMessage()
      }
    }
  }
  
  func ping() {
    websocketTask?.sendPing { error in
      if let error = error {
        print("Error when sending PING \(error)")
      } else {
          print("Web Socket connection is alive")
          DispatchQueue.global().asyncAfter(deadline: .now() + 60) {
            self.ping()
          }
      }
    }
  }
  
  
  deinit {
    disconnect()
  }
}

extension Array where Element: Equatable {
    mutating func move(_ item: Element, to newIndex: Index) {
        if let index = index(of: item) {
            move(at: index, to: newIndex)
        }
    }
    
    mutating func bringToFront(item: Element) {
        move(item, to: 0)
    }
    
    mutating func sendToBack(item: Element) {
        move(item, to: endIndex-1)
    }
}

extension Array {
    mutating func move(at index: Index, to newIndex: Index) {
        insert(remove(at: index), at: newIndex)
    }
}
