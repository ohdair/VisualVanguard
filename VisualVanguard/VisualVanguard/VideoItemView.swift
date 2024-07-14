//
//  VideoItemView.swift
//  VisualVanguard
//
//  Created by 박재우 on 7/14/24.
//

import SwiftUI

struct VideoItem: View {
  let url: URL
  @Binding var isSelected: Bool

  var body: some View {
    HStack {
      Image(systemName: "video")
      Text(url.lastPathComponent)
      Spacer()
      if isSelected {
        Image(systemName: "checkmark")
          .foregroundColor(.blue)
      }
    }
  }
}
