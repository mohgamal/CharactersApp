//
//  CharactersViewController.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import UIKit
import Combine

class CharactersViewController: UIViewController {
    
    // Combine property to hold any subscriptions
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: CharactersViewModelProtocol
    var tableView = UITableView()
    
    // Variable to hold the current status filter
    var selectedStatus: String?
    
    // Add the custom StatusFilterView at the top
    let statusFilterView = StatusFilterView()
    
    init(viewModel: CharactersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ensure large titles are enabled for this view
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        setupStatusFilterView()
        setupTableView()
        bindViewModel()
        fetchData(withStatus: nil)
    }
    
    func bindViewModel() {
        // Observe the characters subject and reload the table view when the data changes
        viewModel.charactersSubject
            .receive(on: RunLoop.main)  // Ensure updates happen on the main thread
            .sink { [weak self] _ in
                guard let self else { return }
                self.tableView.reloadData()
                // Scroll to the top of the table view (first row)
                if self.viewModel.numberOfRowsInSection() > 0 && selectedStatus != nil {
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
            .store(in: &cancellables)  // Store the subscription to keep it alive
    }
    
    func setupStatusFilterView() {
        // Add the custom StatusFilterView to the main view
        view.addSubview(statusFilterView)
        statusFilterView.backgroundColor = .white
        // Set Auto Layout constraints for the filter view to be positioned below the navigation bar
        statusFilterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Anchor the top of the filter view below the navigation bar's safe area
            statusFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusFilterView.heightAnchor.constraint(equalToConstant: 70) // Adjust height as needed
        ])
        
        // Optionally set button actions
        statusFilterView.setButtonActions(
            aliveAction: #selector(toggleAliveFilter),
            deadAction: #selector(toggleDeadFilter),
            unknownAction: #selector(toggleUnknownFilter),
            target: self
        )
    }
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none // This disables the default separator lines
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
        tableView.rowHeight = 120 // Set the height for each cell
        view.addSubview(tableView)
        
        // Set Auto Layout constraints for the table view
        NSLayoutConstraint.activate([
            // Table view below the status filter view
            tableView.topAnchor.constraint(equalTo: statusFilterView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // Actions for the filter buttons
    @objc func toggleAliveFilter() {
        statusFilterView.toggleButtonSelection(statusFilterView.aliveButton)  // Toggle the button state
        if statusFilterView.currentlySelectedButton == statusFilterView.aliveButton {
            fetchData(withStatus: "alive")
        } else {
            fetchData(withStatus: nil)  // Fetch all characters if deselected
        }
    }
    
    @objc func toggleDeadFilter() {
        statusFilterView.toggleButtonSelection(statusFilterView.deadButton)  // Toggle the button state
        if statusFilterView.currentlySelectedButton == statusFilterView.deadButton {
            fetchData(withStatus: "dead")
        } else {
            fetchData(withStatus: nil)  // Fetch all characters if deselected
        }
    }
    
    @objc func toggleUnknownFilter() {
        statusFilterView.toggleButtonSelection(statusFilterView.unknownButton)  // Toggle the button state
        if statusFilterView.currentlySelectedButton == statusFilterView.unknownButton {
            fetchData(withStatus: "unknown")
        } else {
            fetchData(withStatus: nil)  // Fetch all characters if deselected
        }
    }
    
    func fetchData(withStatus status: String?) {
        viewModel.fetchCharacters(withStatus: status)
    }
    
    func resetCharacters() {
        viewModel.charactersSubject.send([])  // Clear the current characters
    }
}
