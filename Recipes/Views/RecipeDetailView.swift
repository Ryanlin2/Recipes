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
    @Query var savedItems: [SavedRecipe]
    @Query var favoriteItems: [FavoriteRecipe]

    var isSaved: Bool {
        savedItems.contains { $0.uuid == recipe.uuid }
    }
    
    var isFavorite: Bool {
        favoriteItems.contains { $0.uuid == recipe.uuid }
    }
    
    // Build an array of image URLs (adjust based on your model)
    var imageURLs: [String] {
        var urls = [String]()
        if let large = recipe.photoURLLarge, !large.isEmpty { urls.append(large) }
        if let small = recipe.photoURLSmall, !small.isEmpty { urls.append(small) }
        return urls
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Slide Show Section
                if !imageURLs.isEmpty {
                    RecipeSlideshowView(imageURLs: imageURLs)
                }
                
                // Recipe Details Section
                Text(recipe.name)
                    .font(.title)
                    .bold()
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Extra Spacer at bottom prevents toolbar from covering content
                Spacer(minLength: 80)
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        // Bottom toolbar with Save and Favorite buttons
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack(spacing: 16) {
                    Button(action: toggleSave) {
                        Text(isSaved ? "Saved" : "Save")
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
        if let existing = savedItems.first(where: { $0.uuid == recipe.uuid }) {
            modelContext.delete(existing)
        } else {
            let newSaved = SavedRecipe(uuid: recipe.uuid, name: recipe.name, cuisine: recipe.cuisine, photoURL: recipe.photoURLSmall)
            modelContext.insert(newSaved)
        }
    }
    
    func toggleFavorite() {
        if let existing = favoriteItems.first(where: { $0.uuid == recipe.uuid }) {
            modelContext.delete(existing)
        } else {
            let newFavorite = FavoriteRecipe(uuid: recipe.uuid, name: recipe.name, cuisine: recipe.cuisine, photoURL: recipe.photoURLSmall)
            modelContext.insert(newFavorite)
        }
    }
}
