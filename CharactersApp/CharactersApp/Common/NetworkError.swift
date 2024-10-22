//
//  NetworkError.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 22/10/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
