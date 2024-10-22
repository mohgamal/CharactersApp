//
//  CharacterDetailsViewModel.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 22/10/2024.
//

import SwiftUI
import Combine

// ViewModel for the Character details
class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    // This could be extended with more logic, like fetching data from an API
}
