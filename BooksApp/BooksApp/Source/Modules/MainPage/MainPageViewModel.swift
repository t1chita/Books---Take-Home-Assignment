//
//  MainPageViewModel.swift
//  BooksApp
//
//  Created by Temur Chitashvili on 22.12.24.
//

import Foundation

enum SearchBy {
    case title
    case authorName
}

final class MainPageViewModel: ObservableObject {
    @Published var books = BookResponse.mockBookResponse
    @Published var searchQuery: String = ""
    @Published var searchByText: String = "Search Book By Title"
    @Published var searchBy: SearchBy = .title
    @Published var isSortedAlphabetically: Bool = false
    
    var filteredBooks: [Book] {
        // Step 1: Filter books based on searchQuery and searchBy criteria
        var result: [Book]
        
        if searchQuery.isEmpty {
            result = books.books
        } else if searchBy == .title {
            result = books.books.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        } else if searchBy == .authorName {
            result = books.books.filter { $0.authors.lowercased().contains(searchQuery.lowercased()) }
        } else {
            result = []
        }
        
        // Step 2: Sort alphabetically by title if isSortedAlphabetically is true
        if isSortedAlphabetically {
            result = result.sorted { $0.title.lowercased() < $1.title.lowercased() }
        }
        
        return result
    }
}

