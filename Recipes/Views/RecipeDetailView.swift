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
            ToolbarItem(placement: .bottomBar) {
                HStack(spacing: 20) {
                    Button(action: toggleSave) {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(width: 160, height: 60)
                            .background(Color.blue.opacity(0.15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .cornerRadius(16)
                    }

                    Button(action: toggleFavorite) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.system(size: 28))
                            .frame(width: 160, height: 60)
                            .background(Color.red.opacity(0.15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                            .cornerRadius(16)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
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
