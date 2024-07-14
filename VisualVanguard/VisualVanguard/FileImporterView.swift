//
//  FileImporterView.swift
//  VisualVanguard
//
//  Created by 박재우 on 7/14/24.
//

import SwiftUI

struct FileImporter: View {
  @Binding var videos: [URL]
  
  var body: some View {
    Button("Import Videos") {
      let panel = NSOpenPanel()
      panel.allowsMultipleSelection = true
      panel.canChooseDirectories = false
      panel.canCreateDirectories = false
      panel.allowedContentTypes = [.movie]
      
      if panel.runModal() == .OK {
        for url in panel.urls {
          copyVideoToAppDirectory(from: url)
        }
        loadVideos()
      }
    }
  }
  
  func copyVideoToAppDirectory(from sourceURL: URL) {
    guard let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
    let newURL = destinationURL.appendingPathComponent(sourceURL.lastPathComponent)
    
    do {
      try FileManager.default.copyItem(at: sourceURL, to: newURL)
    } catch {
      print("Error copying file: \(error)")
    }
  }
  
  func loadVideos() {
    // 앱 내부 디렉토리에서 비디오 파일 로드
  }
}
