// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import Testing
@testable import BookManagerData

struct BookTests {

  @Test func initSetsAllFields() {
    let book = Book(title: "1984", author: "George Orwell", gender: "Male", displayed: false)

    #expect(book.title == "1984")
    #expect(book.author == "George Orwell")
    #expect(book.gender == "Male")
    #expect(book.displayed == false)
  }

  @Test func displayedDefaultsToTrue() {
    let book = Book(title: "T", author: "A", gender: "Male")
    #expect(book.displayed == true)
  }

  @Test func equalityUsesTitleAndAuthor() {
    let a = Book(title: "Same", author: "Same Author", gender: "Male")
    let b = Book(title: "Same", author: "Same Author", gender: "Female")
    let c = Book(title: "Different", author: "Same Author", gender: "Male")

    #expect(a == b)  // gender differs but title+author match
    #expect(a != c)
  }

  @Test func comparableSortsByTitle() {
    let alpha = Book(title: "Alpha", author: "Z", gender: "Male")
    let bravo = Book(title: "Bravo", author: "A", gender: "Male")

    #expect(alpha < bravo)
    #expect(!(bravo < alpha))
  }
}
