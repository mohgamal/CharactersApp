//
//  CharactersViewModel.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import Combine

protocol CharactersViewModelProtocol {
    var charactersSubject: CurrentValueSubject<[Character], Never> { get }
    var reloadTableView: (() -> Void)? { get set }
    var nextPageURL: String? { get }
    func fetchCharacters(withStatus status: String?)
    func numberOfRowsInSection() -> Int
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character
    func fetchNextPageIfNeeded(for indexPath: IndexPath)
}

class CharactersViewModel: CharactersViewModelProtocol {
    
    var charactersService: CharctersServiceProtocol
    var coordinator: MainCoordinator?
    var charactersSubject = CurrentValueSubject<[Character], Never>([])
    var reloadTableView: (() -> Void)?
    var nextPageURL: String?
    var showError: ((String) -> Void)?
    
    init(charactersService: CharctersServiceProtocol) {
        self.charactersService = charactersService
    }
    
    func fetchCharacters(withStatus status: String?) {
        charactersService.status = status
        charactersService.fetchCharacters { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                // Append new characters to the existing array
                let currentCharacters = self.charactersSubject.value
                self.charactersSubject.send(currentCharacters + characters.results)  // Append and send new characters
                if charactersService.status == nil {
                    charactersService.urlString = characters.info.next
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return  charactersSubject.value.count
    }
    
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character {
        return charactersSubject.value[indexPath.row]
    }
    
    func fetchNextPageIfNeeded(for indexPath: IndexPath) {
        if indexPath.row ==  charactersSubject.value.count - 1 {
            fetchCharacters(withStatus: nil) // Fetch next page when the user reaches the bottom of the list
        }
    }
    
}
