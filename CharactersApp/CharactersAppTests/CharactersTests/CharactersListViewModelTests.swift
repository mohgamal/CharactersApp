//
//  CharactersListViewModelTests.swift
//  CharactersAppTests
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import XCTest
@testable import CharactersApp

class CharactersViewModelTests: XCTestCase {
    
    var viewModel: CharactersViewModel!
    var mockNetworkService: CharctersServiceMock!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkService = CharctersServiceMock()
        viewModel = CharactersViewModel(charactersService: mockNetworkService)
    }
    
    func testFetchCharactersCalled() {
        // Given
        let mockViewModel = MockCharactersViewModel()
        
        // When
        mockViewModel.fetchCharacters()
        
        // Then
        XCTAssertTrue(mockViewModel.fetchCharactersCalled, "fetchCharacters() should be called")
    }
    
    func testNumberOfRowsInSection() {
        // Given
        let mockViewModel = MockCharactersViewModel()
        mockViewModel.characters = [
            Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        ]
        
        // When
        let numberOfRows = mockViewModel.numberOfRowsInSection()
        
        // Then
        XCTAssertEqual(numberOfRows, 1, "Number of rows should match the characters count")
    }
    func testFetchCharactersSuccess() {
        // Arrange: Prepare mock data
        let mockCharacter = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        
        let mockResponse = CharactersResponse(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: [mockCharacter])
        mockNetworkService.mockCharactersResponse = mockResponse
        
        let expectation = XCTestExpectation(description: "Fetch Characters")
        
        viewModel.reloadTableView = {
            expectation.fulfill()
        }
        
        // Act: Fetch characters
        viewModel.fetchCharacters()
        
        // Assert: Ensure the characters array is populated correctly
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters[0].name, "Rick Sanchez")
    }
    
    func testFetchCharactersFailure() {
        // Arrange: Simulate network failure (no response)
        mockNetworkService.mockCharactersResponse = nil  // No response to trigger failure
        
        let expectation = XCTestExpectation(description: "Fetch Characters Failure")
        var capturedError: String?
        
        viewModel.showError = { error in
            capturedError = error
            expectation.fulfill()
        }
        
        // Act: Fetch characters (expect failure)
        viewModel.fetchCharacters()
        
        // Assert: Ensure the error was captured and no data was added
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.characters.count, 0, "Characters array should remain empty on failure")
        XCTAssertNotNil(capturedError, "Error message should be captured on failure")
    }

    
    func testCharacterAtIndexPath() {
        // Arrange: Add mock characters
        let character1 = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        let character2 = Character(id: 2, name: "Morty Smith", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        
        viewModel.characters = [character1, character2]
        
        // Act: Get the character at the second index
        let character = viewModel.characterAtIndexPath(IndexPath(row: 1, section: 0))
        
        // Assert: Verify the correct character is returned
        XCTAssertEqual(character.name, "Morty Smith")
    }
    
    func testPaginationFetchNextPage() {
        // Arrange: Prepare mock data for the first and second pages
        let mockCharacterPage1 = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        
        let mockCharacterPage2 = Character(id: 2, name: "Morty Smith", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        
        let mockResponsePage1 = CharactersResponse(info: Info(count: 2, pages: 2, next: "https://rickandmortyapi.com/api/character?page=2", prev: nil), results: [mockCharacterPage1])
        let mockResponsePage2 = CharactersResponse(info: Info(count: 2, pages: 2, next: nil, prev: nil), results: [mockCharacterPage2])
        
        // Simulate the first page fetch
        mockNetworkService.mockCharactersResponse = mockResponsePage1
        
        let expectationFirstPage = XCTestExpectation(description: "Fetch first page")
        
        viewModel.reloadTableView = {
            expectationFirstPage.fulfill()
        }
        
        // Act: Fetch the first page
        viewModel.fetchCharacters()
        
        // Assert: Ensure the first page is loaded
        wait(for: [expectationFirstPage], timeout: 1.0)
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters[0].name, "Rick Sanchez")
        
        // Now simulate fetching the second page by changing the mock response
        mockNetworkService.mockCharactersResponse = mockResponsePage2
        
        let expectationSecondPage = XCTestExpectation(description: "Fetch second page")
        
        viewModel.reloadTableView = {
            expectationSecondPage.fulfill()
        }
        
        // Act: Trigger fetching the second page when reaching the last row
        viewModel.fetchNextPageIfNeeded(for: IndexPath(row: 0, section: 0))
        
        // Assert: Ensure the second page is appended
        wait(for: [expectationSecondPage], timeout: 1.0)
        XCTAssertEqual(viewModel.characters.count, 2)
        XCTAssertEqual(viewModel.characters[1].name, "Morty Smith")
    }
    
}
