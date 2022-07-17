//
//  MockData.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import Foundation
import UIKit

struct MockData {
  
  private let titleList = ["제주도 가족여행", "여의도 공원 나드리", "", "강릉 경포대 여행", "할머니 생신", ""]
  private let dateList = ["2022-05-28", "2022-04-30", "2022-04-21", "2022-01-06", "2022-08-04", "2022-06-03"]
  private let albumDetailListType = ["PHOTO", "PHOTO", "PHOTO", "RECORDING", "PHOTO", "RECORDING"]
  
  var albumByDate: [AlbumDate] {
    var albumList = [AlbumDate]()
    
    for (i, name) in photoList.enumerated() {
      let title = titleList[i % 6]
      let album = AlbumDate(albumId: i, title: title, thumbnail: name, date: dateList[i % 6])
      
      albumList.append(album)
    }
    
    return albumList
  }
  
  var albumByKind: [AlbumKind] {
    let favourite = AlbumKind(kind: "FAVORTIE", count: 26)
    let photo = AlbumKind(kind: "PHOTO", count: 112)
    let recording = AlbumKind(kind: "RECORDING", count: 3)
    
    return [favourite, photo, recording]
  }
  
  var photoList: [String] = [
    "photo01", "photo02", "photo03", "photo04", "photo05",
    "photo06", "photo07", "photo08", "photo09", "photo10"
  ]
  
  var albumDetail: AlbumDetail {
    var elements = [AlbumDetailElement]()
    for i in 0..<10 {
      let element = AlbumDetailElement(id: i, type: albumDetailListType[i % 6], fileId: i, date: dateList[i % 6], link: photoList[i % 10], favourite: titleList[i % 6].count % 2 == 0, title: albumDetailListType[i % 6] == "RECORDING" ? "Record-Title" : nil, commentCount: titleList[i % 6].count)
      elements.append(element)
    }
    
    return AlbumDetail(title: titleList[0], elements: elements)
  }
}
