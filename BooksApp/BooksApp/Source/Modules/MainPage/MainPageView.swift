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
            
            content()
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
