// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import SwiftUI
import SwiftData

struct NewBookView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var title: String = ""
    @State private var author: String = ""
    @State private var gender: String = Gender.allGenders[0]
    @State private var displayed: Bool = true

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
                    Button(action: addBook) {
                        HStack {
                            Spacer()
                            Text("Add Book")
                            Spacer()
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .navigationTitle("New Book")
        }
    }

    private func addBook() {
        Library.addBook(title: title, author: author, gender: gender, displayed: displayed, to: modelContext)

        // Reset form
        title = ""
        author = ""
        gender = Gender.allGenders[0]
        displayed = true
    }
}

#Preview {
    NewBookView()
}
