//
//  FilmDetailsViewModel.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import Foundation

final class FilmDetailsViewModel: ObservableObject {
    // MARK: - Property Wrappers
    
    @Published var imageData: Data?
    @Published var isLoading = false
    @Published var error = false
    
    // MARK: - Public Methods
    
    func fetchImage(url: String) {
        isLoading = true
        
        NetworkManager.shared.fetchImage(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.error = false
                self?.isLoading = false
                self?.imageData = data
            case .failure(_):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.error = true
                }
            }
        }
    }
}
