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

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case badResponse
    case decodingError
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .badResponse:
            return "The server responded with an error."
        case .decodingError:
            return "Failed to decode the server response."
        case .unknownError(let message):
            return message
        }
    }
}

@MainActor
final class MainPageViewModel: ObservableObject {
    @Published var books: BookResponse?
    @Published var searchQuery: String = ""
    @Published var searchByText: String = "Search Book By Title"
    @Published var searchBy: SearchBy = .title
    @Published var isSortedAlphabetically: Bool = false
    @Published var isLoading: Bool = false
    @Published var networkError: NetworkError? = nil
    
    var filteredBooks: [Book] {
        var result: [Book]
        
        if searchQuery.isEmpty {
            result = books?.books ?? []
        } else if searchBy == .title {
            result = books?.books.filter { $0.title.lowercased().contains(searchQuery.lowercased()) } ?? []
        } else if searchBy == .authorName {
            result = books?.books.filter { $0.authors.lowercased().contains(searchQuery.lowercased()) } ?? []
        } else {
            result = []
        }
        
        if isSortedAlphabetically {
            result = result.sorted { $0.title.lowercased() < $1.title.lowercased() }
        }
        
        return result
    }
    
    init() {
        Task {
            await getBooks()
        }
    }
    
    func getBooks() async {
        isLoading = true
        networkError = nil
        
        let urlString = "https://www.dbooks.org/api/recent"
        guard let url = URL(string: urlString) else {
            isLoading = false
            networkError = .invalidURL
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                isLoading = false
                networkError = .badResponse
                return
            }
            
            let decodedResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            DispatchQueue.main.async {
                self.books = decodedResponse
                self.isLoading = false
            }
        } catch let decodingError as DecodingError {
            isLoading = false
            networkError = .decodingError
            print("Decoding Error: \(decodingError.localizedDescription)")
        } catch {
            isLoading = false
            networkError = .unknownError(error.localizedDescription)
        }
    }
}
