//
//  SavedRecipesView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import SwiftUI
import SwiftData

struct SavedRecipesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var savedItems: [SavedRecipe]
    @State var recipeViewModel = RecipeViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(savedItems) { saved in
                    if let recipe = recipeViewModel.recipes.first(where: { $0.uuid == saved.uuid }) {
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeListRow(recipe: recipe)
                        }
                    } else {
                        Text("Recipe unavailable")
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Saved Recipes")
            .onAppear {
                recipeViewModel.loadRecipes()
            }
        }
    }

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(savedItems[index])
        }
    }
}
