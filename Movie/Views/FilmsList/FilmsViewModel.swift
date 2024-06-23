//
//  FilmsViewModel.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import Foundation

final class FilmsViewModel: ObservableObject {
    // MARK: - Public Enums
    
    enum SortOption: String, CaseIterable, Identifiable {
        case year = "Year"
        case rating = "Rating"
        
        var id: String { self.rawValue }
    }
    
    enum SortOrder: String {
        case ascending = "Ascending"
        case descending = "Descending"
    }
    
    // MARK: - Property Wrappers
    
    @Published private(set) var films: [Film] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    
    @Published var sortOption: SortOption = .year
    @Published var sortOrder: SortOrder = .ascending
    
    // MARK: - Initializers
    
    init() {
        fetchBox(url: API.films())
    }
    
    // MARK: - Public Methods
    
    func fetchBox(url: String) {
        isLoading = true
        
        NetworkManager.shared.fetchBox(url: url) { [weak self] result in
            switch result {
            case .success(let box):
                self?.isLoading = false
                self?.error = nil
                self?.films = box.films.sorted { $0.year < $1.year }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.error = error.message
                }
            }
        }
    }
    
    func sortFilms() {
        switch sortOrder {
        case .ascending where sortOption == .year:
            films.sort { $0.year < $1.year }
        case .ascending where sortOption == .rating:
            films.sort { ($0.rating ?? 0) < ($1.rating ?? 0) }
        case .descending where sortOption == .year:
            films.sort { $0.year > $1.year }
        case .descending where sortOption == .rating:
            films.sort { ($0.rating ?? 0) > ($1.rating ?? 0) }
        default:
            break
        }
    }
}
