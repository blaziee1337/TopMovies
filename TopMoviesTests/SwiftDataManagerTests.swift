//
//  SwiftDataManagerTests.swift
//  TopMoviesTests
//
//  Created by Halil Yavuz on 03.12.2024.
//

import XCTest
import SwiftData
@testable import TopMovies

final class SwiftDataManagerTests: XCTestCase {
    
    var dataManager: SwiftDataManager!
    var mockContext: ModelContext!
    
    override func setUp() {
        super.setUp()
        let modelSchema = Schema([MovieEntity.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: modelSchema, configurations: config)
        mockContext = ModelContext(container)
        dataManager = SwiftDataManager(context: mockContext)
    }
    
    override func tearDown() {
        dataManager = nil
        mockContext = nil
        super.tearDown()
    }
    
    func testSaveMovies() {
        let movies = [Movie(id: 1, name: "Test Movie", poster: Poster(url: "url"), year: 2023, movieLength: 120, countries: [], genres: [], shortDescription: nil, rating: Rating(imdb: 8.0))]
        
        dataManager.saveMovies(movies)
        let fetchedMovies = dataManager.fetchMovies()
        
        XCTAssertEqual(fetchedMovies.count, 1)
        XCTAssertEqual(fetchedMovies.first?.name, "Test Movie")
    }
    
    func testFetchMovies() {
        let movies = dataManager.fetchMovies()
        XCTAssertEqual(movies.count, 0)
    }
    
    func testFindMovieEntity() {
        let movie = Movie(id: 1, name: "Find Me", poster: Poster(url: "url"), year: 2023, movieLength: 120, countries: [], genres: [], shortDescription: nil, rating: Rating(imdb: 8.0))
        dataManager.saveMovies([movie])
        
        let foundMovie = dataManager.findMovieEntity(by: 1)
        XCTAssertNotNil(foundMovie)
        XCTAssertEqual(foundMovie?.name, "Find Me")
    }
    
    func testDeleteMovie() {
        let movie = Movie(id: 1, name: "Delete Me", poster: Poster(url: "url"), year: 2023, movieLength: 120, countries: [], genres: [], shortDescription: nil, rating: Rating(imdb: 8.0))
        dataManager.saveMovies([movie])
        
        let movieEntity = dataManager.findMovieEntity(by: 1)!
        dataManager.deleteMovie(movieEntity)
        
        XCTAssertNil(dataManager.findMovieEntity(by: 1))
    }
    
    func testUpdateMovieDescription() {
        let movie = Movie(id: 1, name: "Update Me", poster: Poster(url: "url"), year: 2023, movieLength: 120, countries: [], genres: [], shortDescription: nil, rating: Rating(imdb: 8.0))
        dataManager.saveMovies([movie])
        
        dataManager.updateMovieDescription(movie, newDescription: "New Description")
        let updatedMovie = dataManager.findMovieEntity(by: 1)
        
        XCTAssertEqual(updatedMovie?.shortDescription, "New Description")
    }
}

