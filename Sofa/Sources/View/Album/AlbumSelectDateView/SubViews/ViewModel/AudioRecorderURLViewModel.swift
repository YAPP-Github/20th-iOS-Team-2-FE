//
//  AudioRecorderURLViewModel.swift
//  Sofa
//
//  Created by geonhyeong on 2022/06/20.
//

import Foundation
import AVFoundation

class AudioRecorderURLViewModel: ObservableObject {
  @Published public var recordTitle: String = ""
  
  init() {
    fetchRecordings()
  }
  
  func fetchRecordings() {
    let fileManager = FileManager.default
    let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let path = documentDirectory.path
    let directoryContents = try! fileManager.contentsOfDirectory(atPath: path)
    
    // 1개 이상일 경우, 나머지 제거
    if directoryContents.count > 1 {
      let allContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
      deleteRecording(urlsToDelete: Array(allContents[1..<allContents.count]))
    }
    
    // 1개이상이 존재할 경우,
    if let firstTitle = directoryContents.first {
      recordTitle = firstTitle
    }
  }
  
  // 임시 - 저장된 시점 알아내기
  //  func getCreationDate(for file: URL) -> Date {
  //    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
  //       let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
  //      return creationDate
  //    } else {
  //      return Date()
  //    }
  //  }
  
  // [URL] 전체 삭제
  func deleteRecording(urlsToDelete: [URL]) {
    for url in urlsToDelete {
      print(url)
      do {
        try FileManager.default.removeItem(at: url)
      } catch {
        print("File could not be deleted!")
      }
    }
    fetchRecordings()
  }
}
