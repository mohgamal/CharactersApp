//
//  CharactersEndpoint.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 22/10/2024.
//

import Foundation

enum APIEndpoint {
    
    // Define your API paths here
    case characterList
    
    // Base URL for the API (This can come from environment variables)
    var baseURL: String {
        return Environment.apiBaseUrl  // Use environment variable here
    }
    
    // Path for each endpoint
    var path: String {
        switch self {
        case .characterList:
            return "/character"
        }
    }
    
    // Complete URL for the endpoint
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var method: String {
        return "GET"  // You can handle different methods like POST, PUT, etc.
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
}
