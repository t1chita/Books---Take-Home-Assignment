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
        VStack {
            bookList()
        }
    }
    
    private func bookList() -> some View {
        List(mainPageVM.books.books) { book in
            BookCell(book: book) {
                print(book.id)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .background(Color.clear)
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
    }
}

extension BookCell {
    enum Constants {
        static let hStackSmallSpacing: CGFloat? = 10
        static let vStackSmallSpacing: CGFloat? = 8
    }
}

struct BookCell: View {
    let book: Book
    let action: () -> Void
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: Constants.hStackSmallSpacing) {
                if let imageUrl = URL(string: book.image) {
                    BookImage(url: imageUrl)
                }
                
                VStackLayout(alignment: .leading, spacing: Constants.vStackSmallSpacing) {
                    Text(book.title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.myWhite)
                    
                    Text(book.authors)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.myWhite)
                    
                    Text(book.subtitle)
                        .font(.system(size: 10, weight: .regular))
                        .foregroundStyle(.myGray)
                }
                
                
            }
            
            Spacer()
            
            Button {
                action()
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundStyle(.mySecondary)
            }
            .buttonStyle(PlainButtonStyle())
        }

    }
}
#Preview {
    MainPageView(mainPageVM: MainPageViewModel())
        .environmentObject(NavigationManager())
}
