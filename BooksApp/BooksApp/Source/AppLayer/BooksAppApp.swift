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
            NavigationStack(path: $router.navPath) {
                MainPageView(mainPageVM: MainPageViewModel())
                    .navigationDestination(for: NavigationManager.Destination.self) { destination in
                        switch destination {
                        case .details(let id):
                            Text("Details")
                        }
                    }
            }
            .environmentObject(NavigationManager())
        }
    }
}
