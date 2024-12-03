//
//  TopMoviesViewModel.swift
//  TopMovies
//
//  Created by Halil Yavuz on 01.12.2024.
//

import Foundation

final class TopMoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    private let topMoviesUseCase: TopMoviesUseCase
    private var currentPage: Int = 1
    let imagecacheManager: ImageCacheManager
    
    init(topMoviesUseCase: TopMoviesUseCase, cacheManager: ImageCacheManager ) {
        self.topMoviesUseCase = topMoviesUseCase
        self.imagecacheManager = cacheManager
    }
    
    func fetchTopMovies() async {
        guard !isLoading else { return }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        if currentPage == 1 {
            let localMovies = topMoviesUseCase.fetchLocalMovies()
            
            if !localMovies.isEmpty {
                DispatchQueue.main.async {
                    self.movies = localMovies
                    self.isLoading = false
                }
                return
            }
        }
        
        do {
            let fetchedMovies = try await topMoviesUseCase.execute(
                page: currentPage,
                limit: 10,
                sortField: "votes.imdb",
                sortType: "-1",
                type: "movie"
            )
            
            DispatchQueue.main.async {
                self.movies.append(contentsOf: fetchedMovies)
                self.currentPage += 1
                
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print("Ошибка загрузки фильмов: \(error)")
        }
    }
    
    func deleteMovie(_ movie: Movie) {
        topMoviesUseCase.deleteMovie(movie)
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies.remove(at: index)
        }
    }
    
    func updateMovieDescription(_ movie: Movie, newDescription: String) {
        topMoviesUseCase.updateMovieDescription(movie, newDescription: newDescription)
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies[index].shortDescription = newDescription
            
        }
        
    }
}
