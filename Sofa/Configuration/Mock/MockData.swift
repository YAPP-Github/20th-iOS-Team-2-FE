//
//  MockData.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/10.
//

import Foundation
import UIKit

struct MockData {
  
  let titleList = ["제주도 가족여행", "여의도 공원 나드리", "강릉 경포대 여행", "할머니 생신", ""]
  let dateList = ["2022-05-28", "2022-04-30", "2022-04-21", "2022-01-06", "2022-08-04"]
  
  var albumByDate: [Album] {
    var albumList = [Album]()
    
    for (i, name) in photoList.enumerated() {
      let title = titleList[i % 5]
      var album: Album
      
      if title == "" {
        album = Album(albumId: i, title: "\(dateList[i % 5]) 앨범", thumbnail: name, date: dateList[i % 5])
      } else {
        album = Album(albumId: i, title: title, thumbnail: name, date: dateList[i % 5])
      }
      albumList.append(album)
    }
    
    return albumList
  }
  
  var albumByType: [AlbumType] {
    let favourite = AlbumType(kind: "FAVORTIE", count: 26)
    let photo = AlbumType(kind: "PHOTO", count: 112)
    let recording = AlbumType(kind: "RECORDING", count: 3)

    return [favourite, photo, recording]
  }
  
  var photoList: [String] = [
    "photo01", "photo02", "photo03", "photo04", "photo05",
    "photo06", "photo07", "photo08", "photo09", "photo10"
  ]
}
