//
//  CharactersViewController+Tableview.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 22/10/2024.
//

import Foundation
import UIKit
import SwiftUI

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    // TableView Delegate method - when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the selected character
        let selectedCharacter = viewModel.charactersSubject.value[indexPath.row]
        
        viewModel.coordinator?.showCharacterDetail(for: selectedCharacter)
    }
}
