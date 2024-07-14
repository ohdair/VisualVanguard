//
//  ContentView.swift
//  VisualVanguard
//
//  Created by 박재우 on 7/3/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
  @State private var selectedDirectory: String?
  @State private var videos: [URL] = []
  @State private var isImporting: Bool = false
  @State private var selectedVideo: URL?

  var filteredVideos: [URL] {
    guard let selectedDirectory = selectedDirectory else {
      return videos
    }
    return videos.filter { $0.deletingLastPathComponent().lastPathComponent == selectedDirectory }
  }

  var body: some View {
    NavigationSplitView {
      VStack {
        Button("Import Videos") {
          isImporting = true
        }
        .padding()

        DirectoryList(selectedDirectory: $selectedDirectory)
      }
    } content: {
      VideoList(videos: filteredVideos, selectedVideo: $selectedVideo) { newSelection in
        selectedVideo = newSelection
      }
    } detail: {
      if let selectedVideo = selectedVideo {
        VideoPlayerView(url: selectedVideo)
          .id(selectedVideo)
      } else {
        Text("No video selected")
      }
    }
    .fileImporter(
      isPresented: $isImporting,
      allowedContentTypes: [UTType.movie],
      allowsMultipleSelection: true
    ) { result in
      handleImport(result)
    }
    .onAppear {
      loadVideos()
    }
  }

    func handleImport(_ result: Result<[URL], Error>) {
      do {
        let selectedURLs = try result.get()
        for url in selectedURLs {
          if url.startAccessingSecurityScopedResource() {
            copyVideoToAppDirectory(from: url)
            url.stopAccessingSecurityScopedResource()
          }
        }
        loadVideos()
      } catch {
        print("Error importing files: \(error.localizedDescription)")
      }
    }

    func copyVideoToAppDirectory(from sourceURL: URL) {
      guard let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
      let newURL = destinationURL.appendingPathComponent(sourceURL.lastPathComponent)

      do {
        if FileManager.default.fileExists(atPath: newURL.path) {
          try FileManager.default.removeItem(at: newURL)
        }
        try FileManager.default.copyItem(at: sourceURL, to: newURL)
      } catch {
        print("Error copying file: \(error.localizedDescription)")
      }
    }

    func loadVideos() {
      guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

      do {
        let videoURLs = try FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
          .filter { $0.pathExtension.lowercased() == "mp4" }
        videos = videoURLs
      } catch {
        print("Error loading videos: \(error.localizedDescription)")
      }
    }
  }
