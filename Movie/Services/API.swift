//
//  API.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import Foundation

struct API {
    // MARK: - Private Properties
    
    private static var baseUrl = "https://s3-eu-west-1.amazonaws.com"
    
    // MARK: - Public Methods
    
    static func films() -> String {
        createEndpoint(["sequeniatesttask", "films.json"])
    }
    
    // MARK: - Private Methods
    
    private static func createEndpoint(_ components: [String]) -> String {
        var components = components
        components.insert(baseUrl, at: 0)
        
        return components.joined(separator: "/")
    }
}
