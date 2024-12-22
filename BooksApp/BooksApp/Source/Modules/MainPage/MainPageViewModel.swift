//
//  MainPageViewModel.swift
//  BooksApp
//
//  Created by Temur Chitashvili on 22.12.24.
//

import Foundation

final class MainPageViewModel: ObservableObject {
    @Published var books = BookResponse.mockBookResponse
    
}
