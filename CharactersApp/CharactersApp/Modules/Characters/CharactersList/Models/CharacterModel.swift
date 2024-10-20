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

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationInfo
    let location: LocationInfo
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct LocationInfo: Codable {
    let name: String
    let url: String
}
