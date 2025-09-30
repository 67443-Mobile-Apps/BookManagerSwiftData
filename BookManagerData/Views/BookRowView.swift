// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'


import SwiftUI

struct BookRowView: View {
  var book: Book
  
  var body: some View {
    
    NavigationLink(
      destination: BookDetailsView(book: book),
      label: {
        Text(book.title)
          .fontWeight(.bold)
          .font(.body)
      })
  }
}
