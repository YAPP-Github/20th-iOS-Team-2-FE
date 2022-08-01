//
//  StarscreamWebsocket.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/27.
//

import Foundation
import Starscream
import SwiftUI
import Combine
import Alamofire


class StarscreamWebsocket: ObservableObject {
  
  @State var isNewChat = false
//  @Published var receivedData: String = ""
  @Published var ChatData: OriginalChatResponse = OriginalChatResponse(timestamp: "", status: nil, detail: "")
  @ObservedObject var ChatShared = Chat.shared
  
  var webSocket: WebSocket?
  
  private var cancellables = Set<AnyCancellable>()
  
  func connect() {
    guard let url = URL(string: "ws://3.34.94.220:8085/home/1/1") else {
      print("Error: can not create URL")
      return
    }
    
    let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLQUtBTzoyMTczNzMzODA0IiwiaWF0IjoxNjU4MDM4NzA0LCJleHAiOjE2NjU4MTQ3MDR9.Cm1pEFN83ribamFh36WdnSTJI74Crmy2T9XmxElwr1Q"
    
    var request = URLRequest(url: url)
    request.setValue(accessToken, forHTTPHeaderField: "Authorization")
//    request.setValue("13", forHTTPHeaderField: "Sec-WebSocket-Version")
//    request.setValue("permessage-deflate; client_max_window_bits", forHTTPHeaderField: "Sec-WebSocket-Extensions")
//    request.setValue("Upgrade", forHTTPHeaderField: "Connection")
//    request.setValue("websocket", forHTTPHeaderField: "Upgrade")
//    request.setValue("ws", forHTTPHeaderField: "Sec-WebSocket-Protocol")
//    request.setValue("3.34.94.220:8085", forHTTPHeaderField: "Host")
    webSocket = WebSocket(request: request)
    webSocket?.delegate = self
    
    webSocket?.connect()
  }
  
  func send(message: String) {
    webSocket?.write(string: message)
  }
  
  func disconnect() {
    webSocket?.disconnect()
  }
}


extension StarscreamWebsocket: WebSocketDelegate {
  func didReceive(event: WebSocketEvent, client: WebSocketClient) {
    switch event {
    case .connected(let headers):
      isNewChat = true
      //      client.write(string: "YJ")
      print("Connected!")
      print("websocket is connected: \(headers)")
      
    case .disconnected(let reason, let code):
      print("websocket is disconnected: \(reason) with code: \(code)")
    case .text(let text):
      // 4-2
      print(text)
      
      // 웹소켓 접속 직후
      if isNewChat{
        print("isNewChat")
        isNewChat = false
      }else{ // 가족 리스트 업데이트
        guard let data = text.data(using: .utf16),
              let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
              let jsonDict = jsonData as? NSDictionary else {
          return
        }
        
        let decodedData = try! JSONDecoder().decode(OriginalChatResponse.self, from: data)
        ChatData = decodedData // 이거 웹소켓 접속 직후임
        ChatShared.members = decodedData.members!  // 이거 웹소켓 접속 직후임
//        for item in decoded {
//            print("\(item.id ?? 0)\t\(item.icon ?? "")\t\(item.title ?? "")\t\(item.regDate ?? "")")
//        }
        
      }
                
          
          //      guard let data = text.data(using: .utf16),
          //            let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
          //            let jsonDict = jsonData as? NSDictionary,
          //            let messageType = jsonDict["type"] as? String else {
          //        return
          //      }
          //
          //      if messageType == "message",
          //         let messageData = jsonDict["data"] as? NSDictionary,
          //         let messageAuthor = messageData["author"] as? String,
          //         let messageText = messageData["text"] as? String {
          //        print(messageText)
          //        receivedData = messageText
          //
          //
          //      }
          case .binary(let data):
            print("Received data: \(data.count)")
          case .ping(_):
            break
          case .pong(_):
            break
          case .viabilityChanged(_):
            break
          case .reconnectSuggested(_):
            break
          case .cancelled:
            print("websocket is cancelled")
          case .error(let error):
            print("websocket is error = \(error!)")
    }
  }
}
