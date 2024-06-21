//
//  Film.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import Foundation

struct Film: Codable, Hashable {
    // MARK: - Public Properties
    
    let id: Int
    let localizedName, name: String
    let year: Int
    let rating: Double?
    let imageURL: String?
    let description: String?
    let genres: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case localizedName = "localized_name"
        case name, year, rating
        case imageURL = "image_url"
        case description, genres
    }
}

// MARK: - Extension Film

extension Film {
    static func getFilm() -> Film {
        Film(
            id: 1,
            localizedName: "Those Magnificent Men in Their Flying Machines or How I Flew from London to Paris in 25 hours 11 minutes",
            name: "Those Magnificent Men in Their Flying Machines or How I Flew from London to Paris in 25 hours 11 minutes",
            year: 1999,
            rating: 8.656,
            imageURL: "https://plus.unsplash.com/premium_photo-1690217748547-5a9141cb9763?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            description: "Film about something",
            genres: ["Сomedy"]
        )
    }
}
