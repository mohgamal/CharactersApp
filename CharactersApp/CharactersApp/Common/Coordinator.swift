//
//  Coordinator.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
