//
//  RecipePage.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import SwiftData
import SwiftUI
struct RecipeDetailView: View {
    let recipe: Recipe
    private let recipeID: String

    init(recipe: Recipe) {
        self.recipe = recipe
        self.recipeID = recipe.uuid
    }

    @Environment(\.modelContext) var modelContext
    @Query var savedItems: [SavedRecipe]
    @Query var favoriteItems: [FavoriteRecipe]

    var isSaved: Bool {
        savedItems.contains { $0.uuid == recipe.uuid }
    }

    var isFavorite: Bool {
        favoriteItems.contains { $0.uuid == recipe.uuid }
    }

    
    var body: some View {
        // (Your view code remains the same.)
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
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
                
                Text(recipe.name)
                    .font(.title)
                    .bold()
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: toggleSave) {
                    Label(isSaved ? "Unsave" : "Save", systemImage: isSaved ? "bookmark.fill" : "bookmark")
                        .frame(maxWidth: .infinity)
                }
                Button(action: toggleFavorite) {
                    Label(isFavorite ? "Unfavorite" : "Favorite", systemImage: isFavorite ? "heart.fill" : "heart")
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    func toggleSave() {
        if let saved = savedItems.first {
            modelContext.delete(saved)
        } else {
            let newSaved = SavedRecipe(uuid: recipe.uuid, name: recipe.name, cuisine: recipe.cuisine, photoURL: recipe.photoURLSmall)
            modelContext.insert(newSaved)
        }
    }
    
    func toggleFavorite() {
        if let match = favoriteItems.first {
            modelContext.delete(match)
        } else {
            let newFavorite = FavoriteRecipe(uuid: recipe.uuid, name: recipe.name, cuisine: recipe.cuisine, photoURL: recipe.photoURLSmall)
            modelContext.insert(newFavorite)
        }
    }
}
