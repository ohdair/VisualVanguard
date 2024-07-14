//
//  Item.swift
//  VisualVanguard
//
//  Created by 박재우 on 7/3/24.
//

import SwiftUI
import AVKit

struct VideoListView: View {
  let videos: [URL]
  @Binding var selectedVideo: URL?
  let onSelect: (URL) -> Void

  var body: some View {
    List(videos, id: \.self, selection: $selectedVideo) { video in
      VideoItem(url: video, isSelected: Binding(
        get: { self.selectedVideo == video },
        set: { if $0 { self.onSelect(video) } }
      ))
      .onTapGesture {
        self.onSelect(video)
      }
    }
  }
}
