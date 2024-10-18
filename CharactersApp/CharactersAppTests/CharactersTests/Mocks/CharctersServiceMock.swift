//
//  URLRequestMock.swift
//  CharactersAppTests
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
@testable import CharactersApp
class CharctersServiceMock: CharctersServiceProtocol {
    var urlString: String? = "https://rickandmortyapi.com/api/character"
    var mockCharactersResponse: CharactersResponse?

    func fetchCharacters(completion: @escaping (Result<CharactersResponse, Error>) -> Void) {
        if let response = mockCharactersResponse {
            completion(.success(response))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
}
