//
//  CharactersService.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation

protocol CharctersServiceProtocol {
    var urlString: String? { get set }
    func fetchCharacters(withStatus status: String?, completion: @escaping (Result<CharactersResponse, Error>) -> Void)

}

class CharctersService: CharctersServiceProtocol {
    var urlString: String? = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters(withStatus status: String?, completion: @escaping (Result<CharactersResponse, Error>) -> Void) {
        // Append the status filter if provided
             if let status = status {
                 urlString! += "&status=\(status)"
             }
        
        guard let url = URL(string: urlString ?? "") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
