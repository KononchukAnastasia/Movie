//
//  FilmsView.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import SwiftUI

struct FilmsView: View {
    // MARK: - Property Wrappers
    
    @StateObject private var filmsViewModel = FilmsViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                if filmsViewModel.isLoading {
                    LoaderView(color: .gray, size: 40)
                } else if let error = filmsViewModel.error {
                    Text(error)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.orange)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(filmsViewModel.films, id: \.self) { film in
                                NavigationLink(
                                    destination: FilmDetailsView(film: film)
                                ) {
                                    FilmRowView(
                                        name: film.name,
                                        year: film.year,
                                        rating: film.rating,
                                        description: film.description,
                                        genres: film.genres
                                    )
                                    .padding()
                                }
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Films")
            .onAppear {
                filmsViewModel.fetchBox(url: API.films())
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FilmsView()
}
