// Created by Prof. H in 2025
// Part of the BookManagerData project
// Using Swift 6.0
// Qapla'

import SwiftUI

struct AppView: View {
  var body: some View {
    TabView {
            LibraryView()
            .tabItem {
                Image(systemName: "books.vertical")
                Text("Library")
            }

            NewBookView()
            .tabItem {
                Image(systemName: "rectangle.stack.badge.plus")
                Text("New Book")
            }
            
            ChartsView()
            .tabItem {
                Image(systemName: "chart.bar.xaxis")
                Text("Charts")
            }
          }
  }
}

#Preview {
    AppView()
}
