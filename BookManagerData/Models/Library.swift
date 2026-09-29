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

  // MARK: - Seed Sample Data
  static func seedIfEmpty(_ context: ModelContext) {
    let descriptor = FetchDescriptor<Book>()
    let existingCount = (try? context.fetchCount(descriptor)) ?? 0
    guard existingCount == 0 else { return }

    let bookData: [(String, String, String)] = [
      ("The Count of Monte Cristo", "Alexandre Dumas", "Male"),
      ("The Three Musketeers", "Alexandre Dumas", "Male"),
      ("Black Beauty", "Anna Sewell", "Female"),
      ("The Tenant of Wildfell Hall", "Anne Bronte", "Female"),
      ("Adventures of Sherlock Holmes", "Arthur Conan Doyle", "Male"),
      ("The Hound of the Baskervilles", "Arthur Conan Doyle", "Male"),
      ("A Christmas Carol", "Charles Dickens", "Male"),
      ("A Tale of Two Cities", "Charles Dickens", "Male"),
      ("Jane Eyre", "Charlotte Bronte", "Female"),
      ("The Professor", "Charlotte Bronte", "Female"),
      ("Wuthering Heights", "Emily Bronte", "Female"),
      ("1984", "George Orwell", "Male"),
      ("Animal Farm", "George Orwell", "Male"),
      ("To Kill A Mockingbird", "Harper Lee", "Female"),
      ("Uncle Tom's Cabin", "Harriet Beecher Stowe", "Female"),
      ("The Fellowship of the Ring", "J.R.R. Tolkien", "Male"),
      ("The Two Towers", "J.R.R. Tolkien", "Male"),
      ("The Return of the King", "J.R.R. Tolkien", "Male"),
    ]

    for (title, author, gender) in bookData {
      context.insert(Book(title: title, author: author, gender: gender))
    }
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
