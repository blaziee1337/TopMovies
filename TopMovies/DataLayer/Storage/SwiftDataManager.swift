//
//  SwiftDataManager.swift
//  TopMovies
//
//  Created by Halil Yavuz on 02.12.2024.
//

import SwiftUI
import SwiftData

protocol SwiftDataManagerProtocol {
    func saveMovies(_ movies: [Movie])
    func fetchMovies() -> [MovieEntity]
    func findMovieEntity(by id: Int) -> MovieEntity?
    func deleteMovie(_ movie: MovieEntity) 
    func updateMovieDescription(_ movie: Movie, newDescription: String)
    func saveContext()
}

final class SwiftDataManager: SwiftDataManagerProtocol {
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        
    }
    
    func saveMovies(_ movies: [Movie]) {
        for movie in movies {
            
            let movieEntity = MovieEntity(
                id: movie.id,
                name: movie.name,
                posterURL: movie.poster.url,
                year: movie.year,
                movieLength: movie.movieLength,
                countries: movie.countries.map { $0.name }.joined(separator: ", "),
                genres: movie.genres.map { $0.name }.joined(separator: ", "),
                shortDescription: movie.shortDescription,
                imdbRating: movie.rating.imdb
                
            )
            context.insert(movieEntity)
        }
        saveContext()
    }
    
    func fetchMovies() -> [MovieEntity] {
        let request = FetchDescriptor<MovieEntity>()
        return (try? context.fetch(request)) ?? []
    }
    
    func findMovieEntity(by id: Int) -> MovieEntity? {
        let request = FetchDescriptor<MovieEntity>(predicate: #Predicate { $0.id == id })
        return (try? context.fetch(request))?.first
    }
    
    func deleteMovie(_ movie: MovieEntity) {
        context.delete(movie)
        saveContext()
    }
    
    func updateMovieDescription(_ movie: Movie, newDescription: String) {
        if let movieEntity = findMovieEntity(by: movie.id) {
            movieEntity.shortDescription = newDescription
            saveContext()
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                print("Failed to save context: \(error)")
            }
        }
    }
}
