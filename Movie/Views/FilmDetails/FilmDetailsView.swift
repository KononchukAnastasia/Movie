//
//  FilmDetailsView.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import SwiftUI

struct FilmDetailsView: View {
    // MARK: - Property Wrappers
    
    @StateObject private var filmDetailsViewModel = FilmDetailsViewModel()
    
    // MARK: - Public Property
    
    let film: Film
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if filmDetailsViewModel.isLoading {
                    LoaderView(color: .gray, size: 20)
                        .frame(width: 100, height: 100)
                } else if filmDetailsViewModel.error {
                    Image("noImage")
                        .frame(width: 100, height: 100)
                } else if let imageData = filmDetailsViewModel.imageData,
                let uiImage = UIImage(data: imageData)
                {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(film.name)
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .padding(.bottom)
                    
                    Text("Год: \(film.year) ")
                        .foregroundStyle(.black)
                        .font(.subheadline)
                    
                    
                    HStack {
                        Text("Рейтинг:")
                            .font(.subheadline)
                        
                        Text(modifyRaiting(number: film.rating))
                            .foregroundStyle(getRatingColor(number: film.rating ?? 0))
                            .font(.subheadline)
                    }
                    
                    HStack(alignment: .top) {
                        Text("Жанр:")
                            .font(.subheadline)
                        
                        Text(film.genres.joined(separator: ", "))
                            .foregroundStyle(.black)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            
            Divider()
            
            Text(film.description  ?? "")
                .font(.callout)
                .padding(.top)
        }
        .navigationTitle(film.name)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .onAppear {
            filmDetailsViewModel.fetchImage(url: film.imageURL ?? "")
        }
    }
    
    // MARK: - Private Methods

    private func getRatingColor(number: Double) -> Color {
        switch number {
        case ..<5:
                .red
        case 5..<7:
                .gray
        case 7...:
                .green
        default:
                .white
        }
    }

    private func modifyRaiting(number: Double?) -> String {
        String(format: "%.1f", number ?? 0)
            .replacingOccurrences(of: ",", with: ".")
    }
}
// MARK: - Preview

#Preview {
    FilmDetailsView(film: Film.getFilm())
}
