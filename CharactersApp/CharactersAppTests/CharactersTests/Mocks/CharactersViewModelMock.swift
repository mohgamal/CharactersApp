//
//  CharactersViewModelMock.swift
//  CharactersAppTests
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import Combine

@testable import CharactersApp

class MockCharactersViewModel: CharactersViewModelProtocol {
    var coordinator: CharactersApp.CharactersCoordinator?
    
    var charactersSubject = CurrentValueSubject<[Character], Never>([])
    var reloadTableView: (() -> Void)? = nil
    var nextPageURL: String? = nil
    
    var fetchCalled = false  // Track if fetchCharacters was called
    var fetchedStatus: String? = nil  // Track the status passed to fetchCharacters
    
    // Simulated character data
    var characters: [Character] = []
    
    // Simulate fetchCharacters call
    func fetchCharacters(withStatus status: String?) {
        fetchCalled = true
        fetchedStatus = status
        
        // Simulate appending characters
        let currentCharacters = charactersSubject.value
        charactersSubject.send(currentCharacters + characters)
        
        // Simulate pagination if no status is provided
        if status == nil {
            nextPageURL = "next_page_url"
        } else {
            nextPageURL = nil
        }
        
        // Trigger reloadTableView if necessary
        reloadTableView?()
    }
    
    func numberOfRowsInSection() -> Int {
        return charactersSubject.value.count
    }
    
    func characterAtIndexPath(_ indexPath: IndexPath) -> Character {
        return charactersSubject.value[indexPath.row]
    }
    
    func fetchNextPageIfNeeded(for indexPath: IndexPath) {
        // Simulate fetching the next page
        if indexPath.row == charactersSubject.value.count - 1 && nextPageURL != nil {
            fetchCharacters(withStatus: nil)  // Fetch the next page when reaching the last row
        }
    }
}
