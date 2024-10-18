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
    }
    
    func start() {
        let charactersService = CharctersService()
        let viewModel = CharactersViewModel(charactersService: charactersService)
        let viewController = CharactersViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
