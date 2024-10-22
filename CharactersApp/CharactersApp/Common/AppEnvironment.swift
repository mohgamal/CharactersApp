//
//  AppEnvironment.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 22/10/2024.
//

import Foundation

struct Environment {
    static var apiBaseUrl: String {
        return Bundle.main.infoDictionary?["API_BASE_URL"] as? String ?? "https://default.example.com"
    }
}
