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
