//
//  BookResponse.swift
//  BooksApp
//
//  Created by Temur Chitashvili on 22.12.24.
//


import Foundation

// Top-level structure
struct BookResponse: Decodable {
    let status: String
    let total: Int
    let books: [Book]
}

// Nested structure for individual books
struct Book: Decodable, Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let authors: String
    let image: String
    let url: String
}

extension BookResponse {
    static let mockBookResponse = BookResponse(
        status: "ok",
        total: 20,
        books: [
            Book(
                id: "1098127463",
                title: "Security as Code",
                subtitle: "DevSecOps Patterns with AWS",
                authors: "BK Sarthak Das, Virginia Chu",
                image: "https://www.dbooks.org/img/books/1098127463s.jpg",
                url: "https://www.dbooks.org/security-as-code-1098127463/"
            ),
            Book(
                id: "1805112015",
                title: "Financing Investment in Times of High Public Debt",
                subtitle: "2023 European Public Investment Outlook",
                authors: "Floriana Cerniglia, Francesco Saraceno, Andrew Watt",
                image: "https://www.dbooks.org/img/books/1805112015s.jpg",
                url: "https://www.dbooks.org/financing-investment-in-times-of-high-public-debt-1805112015/"
            ),
            Book(
                id: "164200233X",
                title: "ASP.NET Core 6 Succinctly",
                subtitle: "",
                authors: "Dirk Strauss",
                image: "https://www.dbooks.org/img/books/164200233Xs.jpg",
                url: "https://www.dbooks.org/aspnet-core-6-succinctly-164200233x/"
            )
        ]
    )

}
