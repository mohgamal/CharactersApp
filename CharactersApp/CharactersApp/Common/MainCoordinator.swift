//
//  MainCoordinator.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        // Enable large titles for the entire navigation stack
        navigationController.navigationBar.prefersLargeTitles = true
    }

    func start() {
        // Initialize the NetworkService and CharactersViewModel
        let charactersService = CharctersService()
        let viewModel = CharactersViewModel(charactersService: charactersService)
        
        // Initialize the CharactersViewController and pass in the ViewModel
        let charactersViewController = CharactersViewController(viewModel: viewModel)
        
        // Set the title to "Characters"
        charactersViewController.title = "Characters"
        
        // Push the CharactersViewController onto the navigation stack
        navigationController.pushViewController(charactersViewController, animated: false)
    }
}
