//
//  FilmDetailsViewModel.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import Foundation
import Kingfisher

final class FilmDetailsViewModel: ObservableObject {
    // MARK: - Property Wrappers
    
    @Published var imageData: Data?
    @Published var isLoading = false
    @Published var error = false
    
    // MARK: - Public Methods
    
    func fetchImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        isLoading = true
        
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            switch result {
            case .success(let value):
                self?.error = false
                self?.isLoading = false
                self?.imageData = value.data()
                break
            case .failure:
                self?.isLoading = false
                self?.error = true
            }
        }
    }
}
