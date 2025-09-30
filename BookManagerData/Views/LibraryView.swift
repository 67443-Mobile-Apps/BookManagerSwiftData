// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import SwiftUI
import SwiftData

struct LibraryView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(filter: #Predicate<Book> { $0.displayed == true }, sort: \Book.title) private var books: [Book]

  var body: some View {
    NavigationStack {
      List {
        ForEach(books) { book in
          BookRowView(book: book)
        }
        .onDelete(perform: deleteBooks)
      }
      .navigationTitle("Library")
    }
  }

  private func deleteBooks(at offsets: IndexSet) {
    for index in offsets {
      Library.deleteBook(books[index], from: modelContext)
    }
  }
}

#Preview {
  LibraryView()
}
