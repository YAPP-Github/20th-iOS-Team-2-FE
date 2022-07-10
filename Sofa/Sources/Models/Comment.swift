//
//  Comment.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/10.
//

import Foundation

struct Comments: Decodable {
  var comments: [Comment]
}

struct Comment: Decodable {
  var profileLink: String
  var nickname: String
  var roleInFamily: String
  var createdDate: String
  var content: String
  
  static func getDummy() -> Self{
    return Comment(profileLink: "", nickname: "별명", roleInFamily: "엄마", createdDate: "2022-07-03", content: "또 놀러가고싶다또 놀러가고싶다또 놀러가고싶다또 놀러가고싶다또 놀러가고싶다또 놀러가고싶다 \n댓글에 \n계속 \n줄바꿈을 \n누를 \n때 \n별다른 \n제한은 \n없다.\n\n\n\n")
  }
  
  var descriptionContent: String{
    return "\(content)"
  }
  
  var descriptionDate: String{
    return "\(createdDate)"
  }
}
