//
//  FavoriteRecipesView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import SwiftUI
import SwiftData

struct FavoriteRecipesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var favoriteItems: [FavoriteRecipe]
    @State var recipeViewModel = RecipeViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(favoriteItems) { fav in
                    if let recipe = recipeViewModel.recipes.first(where: { $0.uuid == fav.uuid }) {
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeListRow(recipe: recipe)
                        }
                    } else {
                        Text("Recipe unavailable")
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: deleteFavorites)
            }
            .navigationTitle("Favorite Recipes")
            .toolbar {
                EditButton()
            }
            .onAppear {
                recipeViewModel.loadRecipes()
            }
        }
    }

    private func deleteFavorites(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(favoriteItems[index])
        }
    }
}
