//
//  MockSwiftDataManager.swift
//  TopMoviesTests
//
//  Created by Halil Yavuz on 03.12.2024.
//

import XCTest
@testable import TopMovies

final class MockSwiftDataManager: SwiftDataManagerProtocol {
    var saveMoviesCalled = false
    var fetchMoviesCalled = false
    var deleteMovieCalled = false
    var updateMovieDescriptionCalled = false
    var saveContextCalled = false
    
    var mockMovies: [MovieEntity] = []
    
    func saveMovies(_ movies: [Movie]) {
        saveMoviesCalled = true
    }
    
    func fetchMovies() -> [MovieEntity] {
        fetchMoviesCalled = true
        return mockMovies
    }
    
    func findMovieEntity(by id: Int) -> MovieEntity? {
        return mockMovies.first { $0.id == id }
    }
    
    func deleteMovie(_ movie: MovieEntity) {
        deleteMovieCalled = true
    }
    
    func updateMovieDescription(_ movie: Movie, newDescription: String) {
        updateMovieDescriptionCalled = true
    }
    
    func saveContext() {
        saveContextCalled = true
        
    }
}
