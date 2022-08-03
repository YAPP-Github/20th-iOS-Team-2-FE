//
//  Chat.swift
//  Sofa
//
//  Created by 양유진 on 2022/07/31.
//

import Foundation

class Chat: ObservableObject {
  @Published var members: [ChatMember] = []
  @Published var first = true
  
  static let shared = Chat()
}
