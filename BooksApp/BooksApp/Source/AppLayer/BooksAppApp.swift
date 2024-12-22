//
//  BooksAppApp.swift
//  BooksApp
//
//  Created by Temur Chitashvili on 20.12.24.
//

import SwiftUI

@main
struct BooksAppApp: App {
    @StateObject var router: NavigationManager = NavigationManager()
    var body: some Scene {
        WindowGroup {
            MainPageView(mainPageVM: MainPageViewModel())
                .environmentObject(NavigationManager())
        }
    }
}
