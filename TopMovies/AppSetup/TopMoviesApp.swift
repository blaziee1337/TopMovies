//
//  TopMoviesApp.swift
//  TopMovies
//
//  Created by Halil Yavuz on 30.11.2024.
//

import SwiftUI
import SwiftData

@main
struct TopMoviesApp: App {
    
    @Environment(\.modelContext) private var context: ModelContext
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [MovieEntity.self])
        }
        
    }
    
}
