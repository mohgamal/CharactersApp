//
//  URLRequestMock.swift
//  CharactersAppTests
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
@testable import CharactersApp
class CharctersServiceMock: CharctersServiceProtocol {
    
    var status: String? = nil
    var characters: CharactersResponse = .init(info: .init(count: 0, pages: 0, next: nil, prev: nil), results: [])
    var shouldFail = false  // Simulate success or failure

    var urlString: String? = "https://rickandmortyapi.com/api/character"
    var mockCharactersResponse: CharactersResponse?

    func fetchCharacters(completion: @escaping (Result<CharactersApp.CharactersResponse, Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "TestError", code: 0, userInfo: nil)))
        } else {
            completion(.success(characters))
        }
    }
}
