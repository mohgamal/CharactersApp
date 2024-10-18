//
//  CharactersViewModelMock.swift
//  CharactersAppTests
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
@testable import CharactersApp

class MockCharactersViewModel: CharactersViewModelProtocol {
    var characters: [Character] = []
    var reloadTableView: (() -> Void)?
    var nextPageURL: String? = nil

    var fetchCharactersCalled = false
    func fetchCharacters() {
        fetchCharactersCalled = true
        // You can also simulate a response here if needed
    }
    
    func numberOfRowsInSection() -> Int {
        return characters.count
    }
    
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }
    
    func fetchNextPageIfNeeded(for indexPath: IndexPath) {
        // Mocked behavior for pagination
    }
}
