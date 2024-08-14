//
//  NetworkManager.swift
//  Movie
//
//  Created by Анастасия Конончук on 20.06.2024.
//

import Foundation

enum NetworkError: LocalizedError {
    // Invalid request, e.g. invalid URL.
    case badURL(String = "Bad URL or nil.")
    
    // Indicates an error on the transport layer,
    // e.g. not being able to connect to the server.
    case transportError(Error)
    
    // Received an bad response, e.g. non HTTP result.
    case badResponse(String, Int)
    
    // No decoded data.
    case noDecodedData(String = "The data couldn’t be read because it isn’t in the correct format.")
    
    var message: String {
        switch self {
        case .badURL(let message):
            return message
        case .transportError(let error):
            return error.localizedDescription
        case .badResponse(let message, _):
            return message
        case .noDecodedData(let message):
            return message
        }
    }
    
    var statusCode: Int? {
        switch self {
        case .badURL(_):
            return nil
        case .transportError(_):
            return nil
        case .badResponse(_, let statusCode):
            return statusCode
        case .noDecodedData(_):
            return nil
        }
    }
}

final class NetworkManager {
    // MARK: - Public Properties
    
    static let shared = NetworkManager()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
    func fetchBox(
        url: String,
        completion: @escaping (Result<Box, NetworkError>) -> ()
    ) {
        guard let url = URL(string: url) else {
            return completion(.failure(.badURL()))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                if !(200...299).contains(statusCode) {
                    let message = "Bad response.\nStatus code:"
                    let error = "\(message) \(statusCode)"
                    
                    completion(.failure(.badResponse(error, statusCode)))
                    return
                }
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let box = try decoder.decode(Box.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(box))
                }
            } catch {
                completion(.failure(.noDecodedData(error.localizedDescription)))
            }
        }.resume()
    }
}
