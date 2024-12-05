//
//  TopMoviesService.swift
//  TopMovies
//
//  Created by Halil Yavuz on 30.11.2024.
//

import Foundation

protocol TopMoviesServiceProtocol {
    func fetchMovies(page: Int, limit: Int, sortField: String, sortType: String, type: String) async throws -> [Movie]
}

final class TopMoviesService: TopMoviesServiceProtocol {
    
    private let apiKey = "EFK90N8-ZPB4MZ7-KW670Y4-NXPFGSH"
    private let networkService: NetworkService
    private let baseURL = "https://api.kinopoisk.dev/v1.4/movie"
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchMovies(page: Int, limit: Int, sortField: String, sortType: String, type: String) async throws -> [Movie] {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "sortField", value: sortField),
            URLQueryItem(name: "sortType", value: sortType),
            URLQueryItem(name: "type", value: type)
        ]
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        let response: MovieResponse = try await networkService.request(request)
        return response.docs
    }
}
