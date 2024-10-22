//
//  MainCoordinator.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import UIKit
import SwiftUI

class CharactersCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        // Enable large titles for the entire navigation stack
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        // Initialize the NetworkService and CharactersViewModel
        let charactersService = CharctersService()
        let viewModel = CharactersViewModel(charactersService: charactersService, coordinator: self)
        
        // Initialize the CharactersViewController and pass in the ViewModel
        let charactersViewController = CharactersViewController(viewModel: viewModel)
        
        // Set the title to "Characters"
        charactersViewController.title = "Characters"
        
        // Push the CharactersViewController onto the navigation stack
        navigationController.pushViewController(charactersViewController, animated: false)
    }
    
    // Function to show the CharacterDetailView
       func showCharacterDetail(for character: Character) {
           let characterDetailViewModel = CharacterDetailViewModel(character: character)
           let characterDetailView = CharacterDetailView(viewModel: characterDetailViewModel)
           
           // Create a UIHostingController with the SwiftUI view
           let hostingController = UIHostingController(rootView: characterDetailView)
           
           // Push the UIHostingController onto the navigation stack
           navigationController.pushViewController(hostingController, animated: true)
       }
}
