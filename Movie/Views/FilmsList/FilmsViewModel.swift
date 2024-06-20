//
//  FilmsViewModel.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import Foundation

final class FilmsViewModel: ObservableObject {
    // MARK: - Property Wrappers
    
    @Published var films: [Film] = []
    @Published var isLoading = false
    @Published var error: String?
    
    // MARK: - Public Methods
    
    func fetchBox(url: String) {
        isLoading = true
        
        NetworkManager.shared.fetchBox(url: url) { [weak self] result in
            switch result {
            case .success(let box):
                self?.error = nil
                self?.films = box.films
                self?.isLoading = false
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.error = error.message
                }
            }
        }
    }
}
