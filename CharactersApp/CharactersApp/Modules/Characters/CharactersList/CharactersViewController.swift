//
//  CharactersViewController.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation
import UIKit
class CharactersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel: CharactersViewModelProtocol
    var tableView = UITableView()
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
        setupBindings()
        viewModel.fetchCharacters()
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
            aliveAction: #selector(showAliveCharacters),
            deadAction: #selector(showDeadCharacters),
            unknownAction: #selector(showUnknownCharacters),
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
    
    func setupBindings() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        let character = viewModel.characterAtIndexPath(indexPath)
        cell.configure(with: character)
        
        // Check if we need to load more characters
        viewModel.fetchNextPageIfNeeded(for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if viewModel.nextPageURL != nil {
            return LoadingFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.nextPageURL != nil ? 50 : 0
    }

    
      // Define actions for the buttons (filtering based on status)
      @objc func showAliveCharacters() {
          // Implement filtering logic for "Alive" characters
          print("Show Alive characters")
      }
      
      @objc func showDeadCharacters() {
          // Implement filtering logic for "Dead" characters
          print("Show Dead characters")
      }
      
      @objc func showUnknownCharacters() {
          // Implement filtering logic for "Unknown" characters
          print("Show Unknown characters")
      }
}
