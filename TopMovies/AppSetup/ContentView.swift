//
//  ContentView.swift
//  TopMovies
//
//  Created by Halil Yavuz on 30.11.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context: ModelContext

    var body: some View {
        let viewModel = TopMoviesViewModel(
            topMoviesUseCase: TopMoviesUseCase(
                repository: TopMoviesRepository(
                    topMoviesService: TopMoviesService(networkService: NetworkService()),
                    swiftDataManager: SwiftDataManager(context: context)
                )
            ), cacheManager: ImageCacheManager()
        )
        TopMoviesView(viewModel: viewModel)
    }
}
