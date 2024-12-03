//
//  Movie.swift
//  TopMovies
//
//  Created by Halil Yavuz on 30.11.2024.
//

import Foundation

struct MovieResponse: Decodable {
    let docs: [Movie]
}

struct Movie: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let poster: Poster
    let year: Int
    let movieLength: Int?
    let countries: [Countries]
    let genres: [Gengres]
    var shortDescription: String?
    let rating: Rating
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
            return lhs.id == rhs.id
        }
}

struct Countries: Decodable {
    let name: String
}

struct Gengres: Decodable {
    let name: String
}

struct Poster: Decodable {
    let url: String
}

struct Rating: Decodable {
    let imdb: Double
}
