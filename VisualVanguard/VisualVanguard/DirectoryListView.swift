//
//  DirectoryListView.swift
//  VisualVanguard
//
//  Created by 박재우 on 7/14/24.
//

import SwiftUI

struct DirectoryList: View {
  @Binding var selectedDirectory: String?
  @State private var directories: [String] = []
  
  var body: some View {
    List(directories, id: \.self) { directory in
      Text(directory)
        .onTapGesture {
          selectedDirectory = directory
        }
    }
    .onAppear {
      loadDirectories()
    }
  }
  
  func loadDirectories() {
    // 앱 내부 디렉토리에서 하위 디렉토리 로드
  }
}
