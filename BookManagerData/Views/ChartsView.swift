// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import SwiftUI
import SwiftData
import Charts

struct ChartsView: View {
  @Query private var allBooks: [Book]

  var maleAuthoredBooks: [Book] {
    allBooks.filter { $0.gender == "Male" }
  }

  var femaleAuthoredBooks: [Book] {
    allBooks.filter { $0.gender == "Female" }
  }

  func booksFor(_ author: String) -> [Book] {
    allBooks.filter { $0.author == author }
  }

  var body: some View {
        
    VStack {
      Text("Books by Author Gender")
        .font(.headline)
      Chart {
        BarMark(
          x: .value("Gender", "Male"),
          y: .value("Value", maleAuthoredBooks.count)
        )
        BarMark(
          x: .value("Gender", "Female"),
          y: .value("Value", femaleAuthoredBooks.count)
        )
        .foregroundStyle(.pink)
      }
      .frame(height: 250)
      .padding(20)

      Spacer()

      Text("Books by Popular Authors")
        .font(.headline)
      Chart {
        BarMark(
          x: .value("Author", "Shakespeare"),
          y: .value("Value", booksFor("William Shakespeare").count)
        )
        BarMark(
          x: .value("Author", "Tolkien"),
          y: .value("Value", booksFor("J.R.R. Tolkien").count)
        )
        BarMark(
          x: .value("Author", "Austen"),
          y: .value("Value", booksFor("Jane Austen").count)
        )
        BarMark(
          x: .value("Author", "Dickens"),
          y: .value("Value", booksFor("Charles Dickens").count)
        )
        BarMark(
          x: .value("Author", "Bronte"),
          y: .value("Value", booksFor("Charlotte Bronte").count)
        )
      }
      .frame(height: 250)
      .padding(20)
      .foregroundColor(Color.green)
    }
  }
}

#Preview {
  ChartsView()
}
