//
//  MockTopMoviesService.swift
//  TopMoviesTests
//
//  Created by Halil Yavuz on 03.12.2024.
//

import XCTest
@testable import TopMovies

final class MockTopMoviesService: TopMoviesServiceProtocol {
    var fetchMoviesCalled = false
    var mockMovies: [Movie] = []
    
    func fetchMovies(page: Int, limit: Int, sortField: String, sortType: String, type: String) async throws -> [Movie] {
        fetchMoviesCalled = true
        return mockMovies
    }
}
