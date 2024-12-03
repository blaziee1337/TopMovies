//
//  MovieEntity.swift
//  TopMovies
//
//  Created by Halil Yavuz on 02.12.2024.
//

import Foundation
import SwiftData

@Model

final class MovieEntity {
    @Attribute(.unique) var id: Int
    var name: String
    var posterURL: String
    var year: Int
    var movieLength: Int?
    var countries: String
    var genres: String
    var shortDescription: String?
    var imdbRating: Double
    
    init(id: Int, name: String, posterURL: String, year: Int, movieLength: Int?, countries: String, genres: String, shortDescription: String?, imdbRating: Double) {
        self.id = id
        self.name = name
        self.posterURL = posterURL
        self.year = year
        self.movieLength = movieLength
        self.countries = countries
        self.genres = genres
        self.shortDescription = shortDescription
        self.imdbRating = imdbRating
        
    }
}
