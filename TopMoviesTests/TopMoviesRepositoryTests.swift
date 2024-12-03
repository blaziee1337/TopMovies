//
//  TopMoviesRepositoryTests.swift
//  TopMoviesTests
//
//  Created by Halil Yavuz on 03.12.2024.
//

import XCTest
@testable import TopMovies

final class TopMoviesRepositoryTests: XCTestCase {
    
    var repository: TopMoviesRepository!
    var mockTopMoviesService: MockTopMoviesService!
    var mockSwiftDataManager: MockSwiftDataManager!
    
    override func setUp() {
        super.setUp()
        mockTopMoviesService = MockTopMoviesService()
        mockSwiftDataManager = MockSwiftDataManager()
        repository = TopMoviesRepository(topMoviesService: mockTopMoviesService, swiftDataManager: mockSwiftDataManager)
    }
    
    override func tearDown() {
        repository = nil
        mockTopMoviesService = nil
        mockSwiftDataManager = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() async throws {
        let expectedMovies = [Movie(id: 1, name: "Movie 1", poster: Poster(url: "url1"), year: 2024, movieLength: 120, countries: [], genres: [], shortDescription: "Test movie 1", rating: Rating(imdb: 7.5))]
        mockTopMoviesService.mockMovies = expectedMovies
        
        let movies = try await repository.fetchMovies(page: 1, limit: 10, sortField: "name", sortType: "asc", type: "movie")
        
        XCTAssertTrue(mockTopMoviesService.fetchMoviesCalled, "fetchMovies should be called on the service")
        XCTAssertEqual(movies, expectedMovies, "Fetched movies should match expected")
        XCTAssertTrue(mockSwiftDataManager.saveMoviesCalled, "saveMovies should be called on the data manager")
    }
    
    func testFetchLocalMovies() {
        let movieEntity = MovieEntity(id: 1, name: "Movie 1", posterURL: "url1", year: 2024, movieLength: 120, countries: "Country", genres: "Genre", shortDescription: "Test movie 1", imdbRating: 7.5)
        mockSwiftDataManager.mockMovies = [movieEntity]
        
        let movies = repository.fetchLocalMovies()
        
        XCTAssertTrue(mockSwiftDataManager.fetchMoviesCalled, "fetchMovies should be called on the data manager")
        XCTAssertEqual(movies.count, 1, "There should be one movie")
    }
    
    func testDeleteMovie() {
        
        let movie = Movie(id: 1, name: "Movie 1", poster: Poster(url: "url1"), year: 2024, movieLength: 120, countries: [], genres: [], shortDescription: "Test movie 1", rating: Rating(imdb: 7.5))
        mockSwiftDataManager.mockMovies = [MovieEntity(id: 1, name: "Movie 1", posterURL: "url1", year: 2024, movieLength: 120, countries: "Country", genres: "Genre", shortDescription: "Test movie 1", imdbRating: 7.5)]
        
        repository.deleteMovie(movie)
        
        XCTAssertTrue(mockSwiftDataManager.deleteMovieCalled, "deleteMovie should be called on the data manager")
    }
    
    func testUpdateMovieDescription() {
       
        let movie = Movie(id: 1, name: "Movie 1", poster: Poster(url: "url1"), year: 2024, movieLength: 120, countries: [], genres: [], shortDescription: "Test movie 1", rating: Rating(imdb: 7.5))
        let newDescription = "Updated description"
        
        repository.updateMovieDescription(movie, newDescription: newDescription)
        
        XCTAssertTrue(mockSwiftDataManager.updateMovieDescriptionCalled, "updateMovieDescription should be called on the data manager")
    }
}

