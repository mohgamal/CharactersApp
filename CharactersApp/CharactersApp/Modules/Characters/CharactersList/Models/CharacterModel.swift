//
//  CharacterModel.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 18/10/2024.
//

import Foundation

struct CharactersResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String?
    let origin: LocationInfo?
    let location: LocationInfo?
    let image: String
    let episode: [String]?
    let url: String?
    let created: String?
    
    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String? = nil,
        gender: String? = nil,
        origin: LocationInfo? = nil,
        location: LocationInfo? = nil,
        image: String,
        episode: [String]? = nil,
        url: String? = nil,
        created: String? = nil
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

struct LocationInfo: Codable {
    let name: String
    let url: String
}
