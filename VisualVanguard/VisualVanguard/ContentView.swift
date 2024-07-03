//
//  ContentView.swift
//  VisualVanguard
//
//  Created by 박재우 on 7/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]

  var body: some View {
    NavigationSplitView {
      HStack {
        Image(systemName: "folder")
        Text("Screen Savers")
        Spacer()
        Text("\(items.count)")
          .foregroundColor(.secondary)
          .font(.headline)
      }
      .font(.title3)
      .padding(.horizontal, 16)
      List {
        ForEach(items) { item in
          NavigationLink {
            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
          } label: {
            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
          }
        }
        .onDelete(perform: deleteItems)
      }
      .navigationSplitViewColumnWidth(min: 180, ideal: 200)
      .toolbar {
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
    } detail: {
      Text("Select an item")
    }
  }

  private func addItem() {
    withAnimation {
      let newItem = Item(timestamp: Date())
      modelContext.insert(newItem)
    }
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
      }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
