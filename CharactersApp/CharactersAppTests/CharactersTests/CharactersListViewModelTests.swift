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
    
    func testNumberOfRowsInSection() {
        // Given
        let characters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", image: "")
        ]
        mockViewModel.characters = characters
        
        // When
        mockViewModel.charactersSubject.send(characters)  // Simulate fetching characters
        
        // Then
        XCTAssertEqual(mockViewModel.numberOfRowsInSection(), 2)  // There should be 2 rows
    }

    func testCharacterAtIndexPath() {
        // Given
        let characters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", image: "")
        ]
        mockViewModel.characters = characters
        
        // When
        mockViewModel.charactersSubject.send(characters)  // Simulate fetching characters
        
        // Then
        let firstCharacter = mockViewModel.characterAtIndexPath(IndexPath(row: 0, section: 0))
        XCTAssertEqual(firstCharacter.name, "Rick")  // First character should be Rick
        
        let secondCharacter = mockViewModel.characterAtIndexPath(IndexPath(row: 1, section: 0))
        XCTAssertEqual(secondCharacter.name, "Morty")  // Second character should be Morty
    }

    func testFetchNextPageIfNeededWhenReachingLastRow() {
        // Given
        let characters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", image: "")
        ]
        mockViewModel.characters = characters
        mockViewModel.nextPageURL = "next_page_url"  // Simulate pagination is available
        
        // When
        mockViewModel.fetchNextPageIfNeeded(for: IndexPath(row: 1, section: 0))  // Last row
        
        // Then
        XCTAssertTrue(mockViewModel.fetchCalled)  // Ensure fetchCharacters was called for the next page
    }

    func testFetchNextPageIfNeededWhenNotAtLastRow() {
        // Given
        mockViewModel.fetchCalled = false
        let characters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", image: "")
        ]
        
        mockViewModel.charactersSubject.send(characters)
        mockViewModel.nextPageURL = "next_page_url"  // Simulate pagination is available
        
        // When
        mockViewModel.fetchNextPageIfNeeded(for: IndexPath(row: 0, section: 0))  // Not the last row
        
        // Then
        XCTAssertFalse(mockViewModel.fetchCalled)  // Ensure fetchCharacters was not called
    }

    func testFetchNextPageIfNeededWhenNoNextPageAvailable() {
        
        // Given
        mockViewModel.fetchCalled = false
        let characters = [
            Character(id: 1, name: "Rick", status: "Alive", species: "Human", image: ""),
            Character(id: 2, name: "Morty", status: "Alive", species: "Human", image: "")
        ]
        
        mockViewModel.charactersSubject.send(characters)
        mockViewModel.nextPageURL = nil  // No next page available
        
        // When
        mockViewModel.fetchNextPageIfNeeded(for: IndexPath(row: 1, section: 0))  // Last row
        
        // Then
        XCTAssertFalse(mockViewModel.fetchCalled)  // Ensure fetchCharacters was not called
    }

}
