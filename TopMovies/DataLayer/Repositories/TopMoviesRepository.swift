//
//  TopMoviesRepository.swift
//  TopMovies
//
//  Created by Halil Yavuz on 30.11.2024.
//

import Foundation


protocol MovieRepositoryProtocol {
    func fetchMovies(page: Int, limit: Int, sortField: String, sortType: String, type: String) async throws -> [Movie]
    func fetchLocalMovies() -> [Movie]
    func deleteMovie(_ movie: Movie)
    func updateMovieDescription(_ movie: Movie, newDescription: String)
}

final class TopMoviesRepository: MovieRepositoryProtocol {
    
    private let topMoviesService: TopMoviesServiceProtocol
    private let swiftDataManager: SwiftDataManagerProtocol
    
    init(topMoviesService: TopMoviesServiceProtocol, swiftDataManager: SwiftDataManagerProtocol) {
        self.topMoviesService = topMoviesService
        self.swiftDataManager = swiftDataManager
    }
    
    func fetchMovies(page: Int, limit: Int, sortField: String, sortType: String, type: String) async throws -> [Movie] {
        let movies = try await topMoviesService.fetchMovies(page: page, limit: limit, sortField: sortField, sortType: sortType, type: type)
        swiftDataManager.saveMovies(movies)
        return movies
    }
    
    func fetchLocalMovies() -> [Movie] {
        let movieEntities = swiftDataManager.fetchMovies()
        return movieEntities.map { movieEntityToMovie($0) }
    }
    
    func deleteMovie(_ movie: Movie) {
        if let movieEntity = swiftDataManager.findMovieEntity(by: movie.id) {
            swiftDataManager.deleteMovie(movieEntity)
        } else {
            print("Не удалось найти фильм для удаления.")
        }
    }
    
    func updateMovieDescription(_ movie: Movie, newDescription: String) {
        swiftDataManager.updateMovieDescription(movie, newDescription: newDescription)
        
    }

private func movieEntityToMovie(_ entity: MovieEntity) -> Movie {
    return Movie(
        id: entity.id,
        name: entity.name,
        poster: Poster(url: entity.posterURL),
        year: entity.year,
        movieLength: entity.movieLength,
        countries: entity.countries.split(separator: ", ").map { Countries(name: String($0)) },
        genres: entity.genres.split(separator: ", ").map { Gengres(name: String($0)) },
        shortDescription: entity.shortDescription,
        rating: Rating(imdb: entity.imdbRating)
    )
}
}
