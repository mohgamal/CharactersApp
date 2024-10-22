//
//  CharactersListViewModelTests.swift
//  CharactersAppTests
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import XCTest
import Combine
@testable import CharactersApp

class TableViewSpy: UITableView {
    var reloadDataCalled = false
    
    override func reloadData() {
        reloadDataCalled = true
        super.reloadData()
    }
}

class CharactersViewControllerTests: XCTestCase {

    var viewController: CharactersViewController!
    var mockViewModel: MockCharactersViewModel!
    var cancellables: Set<AnyCancellable>!
    var tableViewSpy: TableViewSpy!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockCharactersViewModel()
        viewController = CharactersViewController(viewModel: mockViewModel)
        cancellables = []
        viewController.loadViewIfNeeded()  // To ensure the view is loaded
        // Replace the table view with the spy
        tableViewSpy = TableViewSpy()
        viewController.tableView = tableViewSpy
        
    }

    override func tearDown() {
        viewController = nil
        mockViewModel = nil
        tableViewSpy = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchCharactersCalledWhenAliveButtonTapped() {
        // Given
        mockViewModel.characters = [Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: "")]
        
        // When
        viewController.toggleAliveFilter()
        
        // Then
        XCTAssertTrue(mockViewModel.fetchCalled)
        XCTAssertEqual(mockViewModel.fetchedStatus, "alive")
    }

    func testFetchNextPageWhenReachingBottom() {
        // Given
        let characters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", image: "")
        ]
        mockViewModel.characters = characters
        
        // When
        viewController.tableView.reloadData()
        mockViewModel.fetchNextPageIfNeeded(for: IndexPath(row: 1, section: 0))
        
        // Then
        XCTAssertTrue(mockViewModel.fetchCalled)  // Ensure fetchNextPage was called
        XCTAssertEqual(mockViewModel.nextPageURL, "next_page_url")  // Simulate pagination
    }
    
    func testReloadTableViewCalled() {
        // Given
        mockViewModel.characters = [Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: "")]
        
        // When
        var reloadTableViewCalled = false
        mockViewModel.reloadTableView = {
            reloadTableViewCalled = true
        }
        
        viewController.toggleAliveFilter()
        
        // Then
        XCTAssertTrue(reloadTableViewCalled)  // Ensure reloadTableView is called
    }

    func testFetchCharactersDeselectingFilter() {
        // Given
        mockViewModel.characters = [Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: "")]
        
        // When
        viewController.toggleAliveFilter()  // First click selects the filter
        viewController.toggleAliveFilter()  // Second click deselects it
        
        // Then
        XCTAssertNil(viewController.statusFilterView.currentlySelectedButton)  // Ensure no button is selected
        XCTAssertEqual(mockViewModel.fetchedStatus, nil)  // Ensure the status was cleared
    }
}
