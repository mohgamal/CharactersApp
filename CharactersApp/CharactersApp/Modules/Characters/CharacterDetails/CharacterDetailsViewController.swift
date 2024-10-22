//
//  CharacterDetailsViewController.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 22/10/2024.
//

import Foundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CharacterDetailView(viewModel: CharacterDetailViewModel(
                character: Character(id: 1, name: "Zephyr", status: "Status", species: "Elf", gender: "Male", location: .init(name: "Earth", url: ""), image: "https://yourimageurl.com/zephyr.jpg")
            ))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
