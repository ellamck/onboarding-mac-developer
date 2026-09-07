//
//  NetworkManager.swift
//  
//
//  Created by Ella McKercher on 2026-09-07.
//

import Foundation

class NetworkManager {
    // Make the manager a singleton so that it can be accessed easily
    // Static makes the constant shared belong to the NetworkManager class itself
    static let shared = NetworkManager()
    
    // Enforce the singleton, prevent other instances from being created
    private init() {
    }
    
    // fetch the URL as that type, example: fetch(url: aURL, as: WeatherResponse.self)
    // Type as the value, because we need the type to properly decode it
    func fetch<T: Decodable>(url: URL, as type: T.Type) async throws -> T { // Returns type T value, ex: WeatherResponse
        
        let(data, _) = try await URLSession.shared.data(from: url) // Ignore response data and fetch raw data
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
    
    // Decodable for response, encodable for what is being sent
    // body is actual instance of type U
    // still need to pass the reference to the decodable type so it can decode the response
    func post<T: Decodable, U: Encodable>(url: URL, body: U, as type: T.Type) async throws -> T {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // encode the provided body into raw json data
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        // return the response from the post
        return decoded
    }
}

// example
// let response = try await NetworkManager.shared.post(url: someURL, body: NewPost(title: "Hello", body: "Content", userId: 1), as PostResponse.self)

struct CurrentWeather: Codable {
    let temperature: Double
    let windspeed: Double
}

struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let current_weather: CurrentWeather
}
