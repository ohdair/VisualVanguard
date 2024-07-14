//
//  VideoPlayerView.swift
//  VisualVanguard
//
//  Created by 박재우 on 7/14/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
  let url: URL
  @State private var player: AVPlayer?

  var body: some View {
    VStack {
      if let player = player {
        VideoPlayer(player: player)
          .aspectRatio(16/9, contentMode: .fit)
      } else {
        Text("Loading video...")
      }
      Text(url.lastPathComponent)
        .font(.headline)

      HStack {
        Button("Play") {
          player?.play()
        }
        Button("Pause") {
          player?.pause()
        }
        Button("Restart") {
          player?.seek(to: .zero)
          player?.play()
        }
      }
      .padding()
    }
    .onAppear {
      setupPlayer()
    }
    .onDisappear {
      player?.pause()
      player = nil
    }
  }

  private func setupPlayer() {
    player = AVPlayer(url: url)
  }
}
