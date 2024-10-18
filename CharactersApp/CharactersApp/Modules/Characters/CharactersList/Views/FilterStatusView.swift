//
//  FilterStatusView.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import UIKit
import UIKit

class StatusFilterView: UIView {
    
    // Stack view for the statuses
    let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Buttons for each status
    let aliveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alive", for: .normal)
        button.setTitleColor(.black, for: .normal) // Set text color to black
        button.backgroundColor = .clear // Clear background
        button.layer.borderWidth = 1.0 // Border width of 1
        button.layer.borderColor = UIColor.black.cgColor // Border color to black
        button.layer.cornerRadius = 8 // Rounded corners
        return button
    }()
    
    let deadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dead", for: .normal)
        button.setTitleColor(.black, for: .normal) // Set text color to black
        button.backgroundColor = .clear // Clear background
        button.layer.borderWidth = 1.0 // Border width of 1
        button.layer.borderColor = UIColor.black.cgColor // Border color to black
        button.layer.cornerRadius = 8 // Rounded corners
        return button
    }()
    
    let unknownButton: UIButton = {
        let button = UIButton()
        button.setTitle("Unknown", for: .normal)
        button.setTitleColor(.black, for: .normal) // Set text color to black
        button.backgroundColor = .clear // Clear background
        button.layer.borderWidth = 1.0 // Border width of 1
        button.layer.borderColor = UIColor.black.cgColor // Border color to black
        button.layer.cornerRadius = 8 // Rounded corners
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear // Set the background of the filter view to clear
        setupStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup the stack view with buttons
    private func setupStackView() {
        // Add buttons to the stack view
        statusStackView.addArrangedSubview(aliveButton)
        statusStackView.addArrangedSubview(deadButton)
        statusStackView.addArrangedSubview(unknownButton)
        
        // Add the stack view to the view
        addSubview(statusStackView)
        
        // Layout the stack view using Auto Layout
        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            statusStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            statusStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Optionally add methods to attach actions to the buttons if needed
    func setButtonActions(aliveAction: Selector, deadAction: Selector, unknownAction: Selector, target: Any) {
        aliveButton.addTarget(target, action: aliveAction, for: .touchUpInside)
        deadButton.addTarget(target, action: deadAction, for: .touchUpInside)
        unknownButton.addTarget(target, action: unknownAction, for: .touchUpInside)
    }
}
