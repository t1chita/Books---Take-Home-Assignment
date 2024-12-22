//
//  BookCell.swift
//  BooksApp
//
//  Created by Temur Chitashvili on 22.12.24.
//

import SwiftUI

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

extension BookCell {
    enum Constants {
        static let hStackSmallSpacing: CGFloat? = 10
        static let vStackSmallSpacing: CGFloat? = 8
    }
}
