//
//  Box.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import Foundation

struct Box: Decodable {
    // MARK: - Public Properties
    
    let movies: [Movie]
}
