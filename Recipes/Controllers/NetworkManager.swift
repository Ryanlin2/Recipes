//
//  NetworkManager.swift
//  Recipes
//
//  Created by Ryan Lin on 4/11/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(RecipeWrapper.self, from: data)
                completion(.success(decoded.recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

