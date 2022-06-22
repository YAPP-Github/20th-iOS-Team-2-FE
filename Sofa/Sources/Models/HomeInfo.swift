//
//  HomeInfo.swift
//  Sofa
//
//  Created by 양유진 on 2022/06/23.
//

import Foundation

struct HomeInfo: Hashable, Decodable {
  var familyName: String?
  var events: [Event]
}

struct Event: Identifiable, Hashable, Decodable {
  var id: Int
  var title: String?
  var eventDate: String?
}
