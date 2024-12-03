//
//  MockMovieRepository.swift
//  TopMoviesTests
//
//  Created by Halil Yavuz on 03.12.2024.
//

import XCTest
@testable import TopMovies

final class MockMovieRepository: MovieRepositoryProtocol {
    var fetchLocalMoviesCalled = false
    var deleteMovieCalled = false
    var updatedDescription: String?

    func fetchMovies(page: Int, limit: Int, sortField: String, sortType: String, type: String) async throws -> [Movie] {
        return []
    }

    func fetchLocalMovies() -> [Movie] {
        fetchLocalMoviesCalled = true
        return []
    }

    func deleteMovie(_ movie: Movie) {
        deleteMovieCalled = true
    }

    func updateMovieDescription(_ movie: Movie, newDescription: String) {
        updatedDescription = newDescription
    }
}
