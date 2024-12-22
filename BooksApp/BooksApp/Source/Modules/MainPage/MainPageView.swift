//
//  MainPageView.swift
//  BooksApp
//
//  Created by Temur Chitashvili on 22.12.24.
//

import SwiftUI

struct MainPageView: View {
    @StateObject var mainPageVM: MainPageViewModel
    @EnvironmentObject var router: NavigationManager
    
    var body: some View {
        ZStack {
            Color
                .black87
                .ignoresSafeArea()
            
            if mainPageVM.isLoading {
                ProgressView {
                    Text("Books Are Loading")
                        .font(.headline)
                        .foregroundStyle(.myWhite)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.myGray.opacity(0.2))
                )
            } else if let networkError = mainPageVM.networkError {
                // Show error messages based on the network error
                VStack {
                    switch networkError {
                    case .invalidURL:
                        Text("The URL is invalid. Please try again later.")
                            .font(.headline)
                            .foregroundStyle(.myWhite)
                            .multilineTextAlignment(.center)
                            .padding()
                    case .badResponse:
                        Text("The server responded with an error. Please try again.")
                            .font(.headline)
                            .foregroundStyle(.myWhite)
                            .multilineTextAlignment(.center)
                            .padding()
                    case .decodingError:
                        Text("Failed to process the data. Please try again.")
                            .font(.headline)
                            .foregroundStyle(.myWhite)
                            .multilineTextAlignment(.center)
                            .padding()
                    case .unknownError(let message):
                        Text("An unknown error occurred: \(message)")
                            .font(.headline)
                            .foregroundStyle(.myWhite)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    Button(action: {
                        Task {
                            await mainPageVM.getBooks()
                        }
                    }) {
                        Text("Retry")
                            .font(.headline)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(.myGray)
                            )
                            .foregroundStyle(.myWhite)
                    }
                }
            } else {
                content()
            }
        }
        .navigationTitle("Books")
    }
    
    private func content() -> some View {
        VStackLayout(alignment: .leading, spacing: 16) {
            filteringCategories()
            
            sortingBooks()
                .padding(.horizontal)
            
            bookList()
        }
    }
    
    private func bookList() -> some View {
        List(mainPageVM.filteredBooks) { book in
            BookCell(book: book) {
                print(book.id)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .background(Color.clear)
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
        .searchable(text: $mainPageVM.searchQuery, prompt: "Search Book")
    }
    
    private func filteringCategories() -> some View {
        Menu {
            Button("Search Book By Title") {
                mainPageVM.searchBy = .title
                mainPageVM.searchByText = "Search Book By Title"
            }
            Button("Search Book By Author Name") {
                mainPageVM.searchBy = .authorName
                mainPageVM.searchByText = "Search Book By Author Name"
            }
        } label: {
            Text(mainPageVM.searchByText)
                .font(.headline)
                .foregroundStyle(.myWhite)
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.mySecondary)
                        .cornerRadius(20, corners: [.bottomLeft, .topRight])
                )
        }
        .padding(.horizontal)
    }
    
    private func sortingBooks() -> some View {
        HStack {
            Spacer()
            
            Button {
                withAnimation {
                    mainPageVM.isSortedAlphabetically.toggle()
                }
            } label: {
                Text("Sort Alphabetically")
                    .font(.footnote)
                    .foregroundStyle(mainPageVM.isSortedAlphabetically ? .myWhite : .myGray)
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(mainPageVM.isSortedAlphabetically ? Color.mySecondary : Color.mySecondary.opacity(0.5))
                            .cornerRadius(20, corners: [.bottomRight, .topLeft])
                    )
            }
        }
    }
}

#Preview {
    MainPageView(mainPageVM: MainPageViewModel())
        .environmentObject(NavigationManager())
}
