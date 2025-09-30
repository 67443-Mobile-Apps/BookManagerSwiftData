// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import Foundation
import SwiftData

@MainActor
class Library {

  // MARK: - Add Book
  static func addBook(title: String, author: String, gender: String, displayed: Bool, to context: ModelContext) {
    let newBook = Book(title: title, author: author, gender: gender, displayed: displayed)
    context.insert(newBook)
  }

  // MARK: - Delete Book
  static func deleteBook(_ book: Book, from context: ModelContext) {
    context.delete(book)
  }

  // MARK: - Update Book
  static func updateBook(_ book: Book, title: String, author: String, gender: String, displayed: Bool) {
    book.title = title
    book.author = author
    book.gender = gender
    book.displayed = displayed
  }

  // MARK: - Get Displayed Books
  static func getDisplayedBooks(from context: ModelContext) -> [Book] {
    let predicate = #Predicate<Book> { book in
      book.displayed == true
    }
    let descriptor = FetchDescriptor<Book>(predicate: predicate, sortBy: [SortDescriptor(\.title)])

    do {
      return try context.fetch(descriptor)
    } catch {
      print("Error fetching displayed books: \(error)")
      return []
    }
  }

  // MARK: - Get Books by Author
  static func getBooksFor(_ author: String, from context: ModelContext) -> [Book] {
    let predicate = #Predicate<Book> { book in
      book.author == author
    }
    let descriptor = FetchDescriptor<Book>(predicate: predicate)

    do {
      return try context.fetch(descriptor)
    } catch {
      print("Error fetching books for author \(author): \(error)")
      return []
    }
  }

  // MARK: - Get Books by Gender
  static func getMaleAuthoredBooks(from context: ModelContext) -> [Book] {
    let predicate = #Predicate<Book> { book in
      book.gender == "Male"
    }
    let descriptor = FetchDescriptor<Book>(predicate: predicate)

    do {
      return try context.fetch(descriptor)
    } catch {
      print("Error fetching male authored books: \(error)")
      return []
    }
  }

  static func getFemaleAuthoredBooks(from context: ModelContext) -> [Book] {
    let predicate = #Predicate<Book> { book in
      book.gender == "Female"
    }
    let descriptor = FetchDescriptor<Book>(predicate: predicate)

    do {
      return try context.fetch(descriptor)
    } catch {
      print("Error fetching female authored books: \(error)")
      return []
    }
  }

}
