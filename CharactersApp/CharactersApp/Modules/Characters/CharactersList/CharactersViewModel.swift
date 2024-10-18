//
//  CharactersViewModel.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation

protocol CharactersViewModelProtocol {
    var characters: [Character] { get }
    var reloadTableView: (() -> Void)? { get set }
    var nextPageURL: String? { get }
    
    func fetchCharacters()
    func numberOfRowsInSection() -> Int
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character
    func fetchNextPageIfNeeded(for indexPath: IndexPath)
}


class CharactersViewModel: CharactersViewModelProtocol {
    var charactersService: CharctersServiceProtocol
    var coordinator: MainCoordinator?
    var characters: [Character] = []
    var reloadTableView: (() -> Void)?
    var nextPageURL: String?
    var showError: ((String) -> Void)?
    
    init(charactersService: CharctersServiceProtocol) {
        self.charactersService = charactersService
    }
    
    func fetchCharacters() {
        charactersService.fetchCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters.append(contentsOf: response.results)
                self?.charactersService.urlString = response.info.next  // Update URL for the next page
                DispatchQueue.main.async {
                    self?.reloadTableView?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError?(error.localizedDescription)
                }
            }
        }
    }
    func numberOfRowsInSection() -> Int {
        return characters.count
    }
    
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }
    
    func fetchNextPageIfNeeded(for indexPath: IndexPath) {
        if indexPath.row == characters.count - 1 {
            fetchCharacters() // Fetch next page when the user reaches the bottom of the list
        }
    }
}
