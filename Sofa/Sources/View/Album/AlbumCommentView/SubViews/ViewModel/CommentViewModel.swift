//
//  CommentViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/07/10.
//

import Foundation
import Combine

class CommentViewModel: ObservableObject{
  
  //MARK: Properties
  var subscription = Set<AnyCancellable>()
  
  @Published var comments = [Comment]()
  
  var baseUrl = ""
  
  init(){
    fetchComment()
  }
  
  func fetchComment(){
    guard let path = Bundle.main.path(forResource: "CommentMock", ofType: "json")
    else {
      fatalError("Couldn't find file in main bundle.")
    }
    
    guard let jsonString = try? String(contentsOfFile: path) else {
      return
    }
    
    if let infodata = jsonString.data(using: .utf8){
      Just(infodata)
        .decode(type: Comments.self, decoder: JSONDecoder())
        .map{ $0.comments }
        .sink(receiveCompletion: { completion in
          //          print("데이터스트림 완료")
          
        }, receiveValue: { receivedValue in
          //          print("받은 값: \(receivedValue.count)")
          self.comments = receivedValue
        }).store(in: &subscription)
    }
  }
}

