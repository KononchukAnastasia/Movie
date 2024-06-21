//
//  FilmDetailsRowView.swift
//  Movie
//
//  Created by Анастасия Конончук on 21.06.2024.
//

import SwiftUI

struct FilmDetailsRowView: View {
    // MARK: - Public Properties
    
    let name: String
    let year: Int
    let rating: Double?
    let description: String?
    let genres: [String]
    let image: Data?
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .font(.title3)
                    .foregroundStyle(.black)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.subheadline)
                        .foregroundStyle(.black)
                        .padding(.bottom)
                    
                    Text("Год: \(year) ")
                        .foregroundStyle(.black)
                        .font(.subheadline)
                    
                    
                    HStack {
                        Text("Рейтинг:")
                            .font(.subheadline)
                        
                        Text(modifyRaiting(number: rating))
                            .foregroundStyle(getRatingColor(number: rating ?? 0))
                            .font(.subheadline)
                    }
                    
                    HStack {
                        Text("Жанр:")
                            .font(.subheadline)
                        
                        Text(genres.joined(separator: ", "))
                            .foregroundStyle(.black)
                            .font(.subheadline)
                    }
                }
            }
            
            Divider()
            
            Text(description  ?? "")
                .font(.callout)
                .padding(.top)
        }
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

// MARK: - Preview

#Preview {
    FilmDetailsRowView(
        name: "Those Magnificent Men in Their Flying Machines or How I Flew from London to Paris in 25 hours 11 minutes",
        year: 1999,
        rating: 8.656,
        description: "Film about something",
        genres: ["Сomedy"],
        image: nil
    )
}
