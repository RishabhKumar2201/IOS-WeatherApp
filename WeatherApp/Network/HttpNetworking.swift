//
//  HTTPNetworking.swift
//  WeatherApp
//
//  Created by rentamac on 1/26/26.
//

import Foundation

class HttpNetworking : Networking {
    func request<T:Decodable>(endpoint: ApiEndpoint, responseType: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300) ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
        
}
    

