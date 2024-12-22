//
//  MealThumbnailImage.swift
//  BooksApp
//
//  Created by Temur Chitashvili on 22.12.24.
//

import SwiftUI

struct BookImage: View {
    @StateObject var imageLoader: ImageLoader
    
    init(url: URL) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: ImageSize.height)
                    .cornerRadius(20, corners: [.topLeft, .bottomRight])
            } else {
                ProgressView()
                    .frame(height: ImageSize.height)
                    .frame(width: ImageSize.height)
            }
        }
        .onAppear {
            Task {
                await imageLoader.fetchImage()
            }
        }
    }
}

extension BookImage {
    enum ImageSize {
        static let height: CGFloat? = 120
    }
}
