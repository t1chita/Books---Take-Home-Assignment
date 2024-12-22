//
//  MainPageViewModel.swift
//  BooksApp
//
//  Created by Temur Chitashvili on 22.12.24.
//

import Foundation

final class MainPageViewModel: ObservableObject {
    @Published var books = BookResponse.mockBookResponse
    @Published var searchQuery: String = ""
    
    var filteredBooks: [Book] {
        if searchQuery.isEmpty {
            return books.books
        } else {
            return books.books.filter({ $0.title.lowercased().contains(searchQuery.lowercased())})
        }
    }
}
