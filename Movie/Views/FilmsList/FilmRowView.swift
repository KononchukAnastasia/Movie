//
//  FilmRowView.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import SwiftUI

struct FilmRowView: View {
    // MARK: - Public Properties
    
    let name: String
    let year: Int
    let rating: Double?
    let description: String?
    let genres: [String]
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(name)
                    .font(.title3)
                    .foregroundStyle(.black)
                
                Spacer()
                
                Text(modifyRaiting(number: rating))
                    .foregroundStyle(getRatingColor(number: rating ?? 0))
                    .font(.subheadline)
            }
            .padding(.bottom)
            
            Text("(\(year) год)")
                .foregroundStyle(.black)
                .font(.subheadline)
            
            Text(genres.joined(separator: ", "))
                .foregroundStyle(.black)
                .font(.footnote)
                .padding(.bottom, 8)
            
            Text(description  ?? "")
                .foregroundStyle(.gray)
                .lineLimit(4)
                .font(.callout)
        }
        .multilineTextAlignment(.leading)
        .padding()
        .background(.mint.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
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
    FilmRowView(
        name: "Those Magnificent Men in Their Flying Machines or How I Flew from London to Paris in 25 hours 11 minutes",
        year: 1999,
        rating: 8.656,
        description: "Film about something",
        genres: ["Сomedy"]
    )
}
