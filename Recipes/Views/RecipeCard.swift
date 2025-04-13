//
//  RecipeCard.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import Foundation

import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: recipe.photoURLSmall ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .clipped()
                case .failure:
                    Color.gray
                        .frame(height: 150)
                        .overlay(Text("No Image").foregroundColor(.white))
                @unknown default:
                    EmptyView()
                }
            }
            .cornerRadius(10)

            Text(recipe.name)
                .font(.headline)
                .lineLimit(2)

            Text(recipe.cuisine)
                .font(.subheadline)
                .foregroundColor(.secondary)

        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

#Preview{
    @Previewable @State var recipe = Recipe(cuisine: "British", name: "Apple Frangipan Tart", uuid: "74f6d4eb-da50-4901-94d1-deae2d8af1d1", photoURLLarge: Optional("https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg"), photoURLSmall: Optional("https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg"), sourceURL: nil, youtubeURL: Optional("https://www.youtube.com/watch?v=rp8Slv4INLk"))
    
    RecipeCard(recipe:recipe)
}
