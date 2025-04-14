//
//  RecipePage.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    let recipe: Recipe

    @Environment(\.modelContext) var modelContext
    @Query var favorites: [FavoriteRecipe]

    var isFavorite: Bool {
        favorites.contains(where: { $0.uuid == recipe.uuid })
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image
                AsyncImage(url: URL(string: recipe.photoURLLarge ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    case .failure:
                        Color.gray
                            .frame(height: 200)
                            .overlay(Text("No Image").foregroundColor(.white))
                    @unknown default:
                        EmptyView()
                    }
                }

                // Recipe Info
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // Favorite Button
                Button(action: toggleFavorite) {
                    Label(isFavorite ? "Remove from Favorites" : "Save to Favorites",
                          systemImage: isFavorite ? "heart.fill" : "heart")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isFavorite ? Color.red.opacity(0.2) : Color.blue.opacity(0.2))
                        .foregroundColor(isFavorite ? .red : .blue)
                        .cornerRadius(10)
                }

                // Links
                if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL) {
                    Link("View Source", destination: url)
                        .foregroundColor(.blue)
                }

                if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                    Link("Watch on YouTube", destination: url)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    func toggleFavorite() {
        if let match = favorites.first(where: { $0.uuid == recipe.uuid }) {
            modelContext.delete(match)
        } else {
            let favorite = FavoriteRecipe(
                uuid: recipe.uuid,
                name: recipe.name,
                cuisine: recipe.cuisine,
                photoURL: recipe.photoURLSmall
            )
            modelContext.insert(favorite)
        }
    }
}

