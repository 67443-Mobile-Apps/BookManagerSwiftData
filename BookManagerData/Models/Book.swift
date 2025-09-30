// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import Foundation
import SwiftData

@Model
class Book: Identifiable, Comparable {
    
  // MARK: Fields
  var title: String
  var author: String
  var gender: String
  var displayed: Bool
  
  // MARK: Initializer
  init(title: String, author: String, gender: String, displayed: Bool = true) {
    self.title = title
    self.author = author
    self.gender = gender
    self.displayed = displayed
  }
  
  // MARK: Comparable
  static func ==(lhs: Book, rhs: Book) -> Bool {
    return lhs.title == rhs.title && lhs.author == rhs.author
  }
  
  static func <(lhs: Book, rhs: Book) -> Bool {
    return lhs.title < rhs.title
  }
  
}
