// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import SwiftUI
import SwiftData

struct AppView: View {
  @Environment(\.modelContext) private var modelContext

  var body: some View {
    TabView {
      LibraryView()
        .tabItem {
          Image(systemName: "books.vertical")
          Text("Library")
        }

      NewBookView()
        .tabItem {
          Image(systemName: "rectangle.stack.badge.plus")
          Text("New Book")
        }

      ChartsView()
        .tabItem {
          Image(systemName: "chart.bar.xaxis")
          Text("Charts")
        }
    }
    .onAppear {
      Library.seedIfEmpty(modelContext)
    }
  }
}

#Preview {
  AppView()
}
