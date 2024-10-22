//
//  CharactersService.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation

protocol CharctersServiceProtocol {
    var urlString: String? { get set }
    var status: String? { get set }
    func fetchCharacters(completion: @escaping (Result<CharactersResponse, Error>) -> Void)
    
}

class CharctersService: CharctersServiceProtocol {
    var urlString: String? = "\(Environment.apiBaseUrl)character"
    var status: String? = nil
    
    func fetchCharacters(completion: @escaping (Result<CharactersResponse, Error>) -> Void) {
        guard let request = APIEndpoint.characterList.urlRequest else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let charactersResponse = try JSONDecoder().decode(CharactersResponse.self, from: data)
                completion(.success(charactersResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
