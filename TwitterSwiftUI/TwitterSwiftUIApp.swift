//
//  TwitterSwiftUIApp.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 24.02.2022.
//

import SwiftUI
import Firebase

@main
struct TwitterSwiftUIApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(viewModel)
        }
    }
}
