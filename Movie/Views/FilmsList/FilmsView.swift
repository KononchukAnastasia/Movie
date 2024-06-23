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
    
    @State private var isShowOptions = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Sort by", selection: $filmsViewModel.sortOption) {
                    ForEach(FilmsViewModel.SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: filmsViewModel.sortOption) { _, _ in
                        filmsViewModel.sortFilms()
                }
                
                Button(
                    "Sorted by \(filmsViewModel.sortOrder.rawValue.lowercased() )"
                ) {
                    isShowOptions = true
                }
                
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
                                        destination: FilmDetailsView(
                                            film: film)
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
            }
            .confirmationDialog("", isPresented: $isShowOptions) {
                Button(FilmsViewModel.SortOrder.ascending.rawValue) {
                    filmsViewModel.sortOrder = .ascending
                    filmsViewModel.sortFilms()
                }
                
                Button(FilmsViewModel.SortOrder.descending.rawValue) {
                    filmsViewModel.sortOrder = .descending
                    filmsViewModel.sortFilms()
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FilmsView()
}
