// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import Testing
import Foundation
import SwiftData
@testable import BookManagerData

@MainActor
struct LibraryTests {

  // MARK: - Helpers

  private func makeContext() throws -> ModelContext {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Book.self, configurations: config)
    return ModelContext(container)
  }

  // MARK: - addBook

  @Test func addBookInsertsRecord() throws {
    let ctx = try makeContext()

    Library.addBook(title: "1984", author: "George Orwell", gender: "Male", displayed: true, to: ctx)

    let all = try ctx.fetch(FetchDescriptor<Book>())
    #expect(all.count == 1)
    #expect(all.first?.title == "1984")
    #expect(all.first?.author == "George Orwell")
    #expect(all.first?.gender == "Male")
    #expect(all.first?.displayed == true)
  }

  @Test func addBookAllowsHiddenBooks() throws {
    let ctx = try makeContext()

    Library.addBook(title: "Hidden", author: "Anon", gender: "Other", displayed: false, to: ctx)

    let all = try ctx.fetch(FetchDescriptor<Book>())
    #expect(all.first?.displayed == false)
  }

  // MARK: - deleteBook

  @Test func deleteBookRemovesRecord() throws {
    let ctx = try makeContext()
    Library.addBook(title: "A", author: "X", gender: "Male", displayed: true, to: ctx)
    Library.addBook(title: "B", author: "Y", gender: "Female", displayed: true, to: ctx)

    let all = try ctx.fetch(FetchDescriptor<Book>())
    let target = try #require(all.first { $0.title == "A" })
    Library.deleteBook(target, from: ctx)

    let remaining = try ctx.fetch(FetchDescriptor<Book>())
    #expect(remaining.count == 1)
    #expect(remaining.first?.title == "B")
  }

  // MARK: - updateBook

  @Test func updateBookMutatesAllFields() throws {
    let ctx = try makeContext()
    Library.addBook(title: "Old", author: "Old Author", gender: "Male", displayed: true, to: ctx)
    let book = try #require(try ctx.fetch(FetchDescriptor<Book>()).first)

    Library.updateBook(book, title: "New", author: "New Author", gender: "Female", displayed: false)

    #expect(book.title == "New")
    #expect(book.author == "New Author")
    #expect(book.gender == "Female")
    #expect(book.displayed == false)
  }

  // MARK: - getDisplayedBooks

  @Test func getDisplayedBooksReturnsOnlyDisplayed() throws {
    let ctx = try makeContext()
    Library.addBook(title: "Shown 1", author: "A", gender: "Male", displayed: true, to: ctx)
    Library.addBook(title: "Hidden", author: "B", gender: "Female", displayed: false, to: ctx)
    Library.addBook(title: "Shown 2", author: "C", gender: "Male", displayed: true, to: ctx)

    let displayed = Library.getDisplayedBooks(from: ctx)

    #expect(displayed.count == 2)
    #expect(displayed.allSatisfy { $0.displayed })
  }

  @Test func getDisplayedBooksSortsByTitle() throws {
    let ctx = try makeContext()
    Library.addBook(title: "Charlie", author: "A", gender: "Male", displayed: true, to: ctx)
    Library.addBook(title: "Alpha",   author: "B", gender: "Female", displayed: true, to: ctx)
    Library.addBook(title: "Bravo",   author: "C", gender: "Male", displayed: true, to: ctx)

    let displayed = Library.getDisplayedBooks(from: ctx)

    #expect(displayed.map(\.title) == ["Alpha", "Bravo", "Charlie"])
  }

  // MARK: - getBooksFor(author)

  @Test func getBooksForAuthorFiltersCorrectly() throws {
    let ctx = try makeContext()
    Library.addBook(title: "1984",        author: "George Orwell",  gender: "Male", displayed: true, to: ctx)
    Library.addBook(title: "Animal Farm", author: "George Orwell",  gender: "Male", displayed: true, to: ctx)
    Library.addBook(title: "Jane Eyre",   author: "Charlotte Bronte", gender: "Female", displayed: true, to: ctx)

    let orwell = Library.getBooksFor("George Orwell", from: ctx)
    #expect(orwell.count == 2)
    #expect(Set(orwell.map(\.title)) == ["1984", "Animal Farm"])
  }

  @Test func getBooksForAuthorReturnsEmptyWhenNoMatch() throws {
    let ctx = try makeContext()
    Library.addBook(title: "1984", author: "George Orwell", gender: "Male", displayed: true, to: ctx)

    let none = Library.getBooksFor("Nobody", from: ctx)
    #expect(none.isEmpty)
  }

  // MARK: - Gender filters

  @Test func getMaleAuthoredBooksFiltersByGender() throws {
    let ctx = try makeContext()
    Library.addBook(title: "M1", author: "A", gender: "Male",   displayed: true, to: ctx)
    Library.addBook(title: "M2", author: "B", gender: "Male",   displayed: true, to: ctx)
    Library.addBook(title: "F1", author: "C", gender: "Female", displayed: true, to: ctx)

    let male = Library.getMaleAuthoredBooks(from: ctx)
    #expect(male.count == 2)
    #expect(male.allSatisfy { $0.gender == "Male" })
  }

  @Test func getFemaleAuthoredBooksFiltersByGender() throws {
    let ctx = try makeContext()
    Library.addBook(title: "M1", author: "A", gender: "Male",   displayed: true, to: ctx)
    Library.addBook(title: "F1", author: "B", gender: "Female", displayed: true, to: ctx)
    Library.addBook(title: "F2", author: "C", gender: "Female", displayed: true, to: ctx)

    let female = Library.getFemaleAuthoredBooks(from: ctx)
    #expect(female.count == 2)
    #expect(female.allSatisfy { $0.gender == "Female" })
  }

  // MARK: - seedIfEmpty

  @Test func seedIfEmptyInsertsAllRecordsWhenStoreIsEmpty() throws {
    let ctx = try makeContext()

    Library.seedIfEmpty(ctx)

    let all = try ctx.fetch(FetchDescriptor<Book>())
    #expect(all.count == 18)
  }

  @Test func seedIfEmptyIsIdempotent() throws {
    let ctx = try makeContext()

    Library.seedIfEmpty(ctx)
    Library.seedIfEmpty(ctx)
    Library.seedIfEmpty(ctx)

    let all = try ctx.fetch(FetchDescriptor<Book>())
    #expect(all.count == 18)
  }

  @Test func seedIfEmptyDoesNothingWhenStoreHasData() throws {
    let ctx = try makeContext()
    Library.addBook(title: "Only", author: "Solo", gender: "Other", displayed: true, to: ctx)

    Library.seedIfEmpty(ctx)

    let all = try ctx.fetch(FetchDescriptor<Book>())
    #expect(all.count == 1)
    #expect(all.first?.title == "Only")
  }
}
