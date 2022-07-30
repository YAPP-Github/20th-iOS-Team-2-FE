//
//  StarscreamWebsocket.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/27.
//

import Foundation
import Starscream
import Combine

class StarscreamWebsocket: ObservableObject {
  var webSocket: WebSocket?
  @Published var receivedData: String = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  func connect() {
    guard let url = URL(string: "ws://localhost:1337/") else {
      print("Error: can not create URL")
      return
    }
    
    let request = URLRequest(url: url)
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    headers["accept"] = "application/json"
    
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
      client.write(string: "YJ")
      print("Connected!")
      print("websocket is connected: \(headers)")
    case .disconnected(let reason, let code):
      print("websocket is disconnected: \(reason) with code: \(code)")
    case .text(let text):
      // 4-2
      guard let data = text.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonDict = jsonData as? NSDictionary,
            let messageType = jsonDict["type"] as? String else {
        return
      }
      
      if messageType == "message",
         let messageData = jsonDict["data"] as? NSDictionary,
         let messageAuthor = messageData["author"] as? String,
         let messageText = messageData["text"] as? String {
        print(messageText)
        receivedData = messageText

        
      }
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
      print("websocket is canclled")
    case .error(let error):
      print("websocket is error = \(error!)")
    }
  }
}
