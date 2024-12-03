//
//  TopMoviesUseCase.swift
//  TopMovies
//
//  Created by Halil Yavuz on 30.11.2024.
//

import Foundation


protocol TopMoviesUseCaseProtocol {
    func execute(page: Int, limit: Int, sortField: String, sortType: String, type: String) async throws -> [Movie]
    func fetchLocalMovies() -> [Movie]
    func deleteMovie(_ movie: Movie)
    func updateMovieDescription(_ movie: Movie, newDescription: String)
    
}

final class TopMoviesUseCase: TopMoviesUseCaseProtocol {
    private let repository: MovieRepositoryProtocol
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(page: Int, limit: Int, sortField: String, sortType: String, type: String) async throws -> [Movie] {
        return try await repository.fetchMovies(page: page, limit: limit, sortField: sortField, sortType: sortType, type: type)
    }
    
    func fetchLocalMovies() -> [Movie] {
        return repository.fetchLocalMovies()
    }
    
    func deleteMovie(_ movie: Movie) {
        repository.deleteMovie(movie)
    }
    
    func updateMovieDescription(_ movie: Movie, newDescription: String) {
        repository.updateMovieDescription(movie, newDescription: newDescription)
    }
    
}
