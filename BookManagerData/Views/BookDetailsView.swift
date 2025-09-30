// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'


import SwiftUI

struct BookDetailsView: View {
  var book: Book
  @State private var isEditing = false
  @State private var editTitle: String = ""
  @State private var editAuthor: String = ""
  @State private var editGender: String = ""
  @State private var editDisplayed: Bool = true

  var body: some View {
    VStack {
      Text(book.title)
        .font(.title)
        .fontWeight(.black)
        .padding([.top], 40)
      Text("Author:  \(book.author)")
        .font(.title3)
        .fontWeight(.bold)
        .padding(5)
      Text("Author Gender: \(book.gender)")
        .font(.headline)
        .fontWeight(.bold)
        .foregroundColor(.secondary)
        .padding(20)
    }
    .navigationBarTitle(Text("Book Details"), displayMode: .inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Edit") {
          editTitle = book.title
          editAuthor = book.author
          editGender = book.gender
          editDisplayed = book.displayed
          isEditing = true
        }
      }
    }
    .sheet(isPresented: $isEditing) {
      EditBookView(book: book, title: $editTitle, author: $editAuthor, gender: $editGender, displayed: $editDisplayed, isPresented: $isEditing)
    }

    Spacer()  // To force the content to the top
  }
}

struct EditBookView: View {
  var book: Book
  @Binding var title: String
  @Binding var author: String
  @Binding var gender: String
  @Binding var displayed: Bool
  @Binding var isPresented: Bool

  var isFormValid: Bool {
    !title.isEmpty && !author.isEmpty
  }

  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Book Information")) {
          TextField("Book Title", text: $title)
          TextField("Author Name", text: $author)
        }

        Section(header: Text("Author Details")) {
          Picker("Author Gender", selection: $gender) {
            ForEach(Gender.allGenders, id: \.self) { genderOption in
              Text(genderOption).tag(genderOption)
            }
          }
        }

        Section(header: Text("Display Options")) {
          Toggle("Display in Library", isOn: $displayed)
        }

        Section {
          Button(action: saveChanges) {
            HStack {
              Spacer()
              Text("Save Changes")
              Spacer()
            }
          }
          .disabled(!isFormValid)
        }
      }
      .navigationTitle("Edit Book")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") {
            isPresented = false
          }
        }
      }
    }
  }

  private func saveChanges() {
    Library.updateBook(book, title: title, author: author, gender: gender, displayed: displayed)
    isPresented = false
  }
}
