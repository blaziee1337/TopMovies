//
//  TopMoviesTests.swift
//  TopMoviesTests
//
//  Created by Halil Yavuz on 03.12.2024.
//

import XCTest
@testable import TopMovies

final class TopMoviesUseCaseTests: XCTestCase {
    
    var useCase: TopMoviesUseCase!
    var mockRepository: MockMovieRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        useCase = TopMoviesUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchLocalMovies() {
        let movies = useCase.fetchLocalMovies()
        XCTAssertEqual(movies.count, mockRepository.fetchLocalMovies().count)
    }
    
    func testDeleteMovie() {
        let movie = Movie(id: 1, name: "Delete Test",poster: Poster(url: "url"), year: 2023, movieLength: 120, countries: [], genres: [], shortDescription: nil, rating: Rating(imdb: 8.0))
        useCase.deleteMovie(movie)
        
        XCTAssertTrue(mockRepository.deleteMovieCalled)
    }
    
    func testUpdateMovieDescription() {
        let movie = Movie(id: 1, name: "Update Test", poster: Poster(url: "url"), year: 2023, movieLength: 120, countries: [], genres: [], shortDescription: nil, rating: Rating(imdb: 8.0))
        useCase.updateMovieDescription(movie, newDescription: "Updated Description")
        
        XCTAssertEqual(mockRepository.updatedDescription, "Updated Description")
    }
    
}
