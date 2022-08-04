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
    guard let url = URL(string: "ws://3.34.94.220:8085/home/1") else {
      print("Error: can not create URL")
      return
    }
    var request = URLRequest(url: url)
//    request.addValue(Constant.accessToken ?? "", forHTTPHeaderField: "Authorization")
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
    websocketTask?.receive { [self] result in
      switch result {
      case .failure(let error):
        print("Error in receiving message: \(error)")
      case .success(let message):
        switch message {
        case .string(let text):
//          print("Received string: \(text)")
          if ChatShared.first == true{ // 가장 처음
            if let chatData = text.data(using: .utf8){
              Just(chatData)
                .decode(type: OriginalChatResponse.self, decoder: JSONDecoder())
                .map{ $0.members }
                .sink(receiveCompletion: { completion in
//                  print("데이터스트림 완료")

                }, receiveValue: { receivedValue in
                  print("ChatScreen 받은 값: \(receivedValue?.count ?? 0)")
                  DispatchQueue.main.async {
                    self.ChatShared.members = receivedValue ?? []
                    self.ChatShared.first = false
                    for i in (0...receivedValue!.count-1){
                      self.ChatShared.indexs[receivedValue![i].userId] = i
                    }
                  }
                  
                }).store(in: &subscription)
            }
          }else{
            // 처음이 아니라면 싱글톤 객체에 추가됨
            print("firstConnected: \(ChatShared.first)")
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
                    print("Received string: \(text)")
                    DispatchQueue.main.async {
                      self.ChatShared.members[idx].content = receivedValue.content
                      self.ChatShared.members[idx].updatedAt = "방금전"
                      self.ChatShared.moveIndex = idx
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
