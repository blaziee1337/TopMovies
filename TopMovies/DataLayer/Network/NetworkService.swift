//
//  NetworkService.swift
//  TopMovies
//
//  Created by Halil Yavuz on 30.11.2024.
//

import Foundation

final class NetworkService {
    func request<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
