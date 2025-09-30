// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import SwiftUI
import SwiftData

@main
struct BookManagerDataApp: App {
  var body: some Scene {
    WindowGroup {
      AppView()
    }
    .modelContainer(for: Book.self)
  }
}
