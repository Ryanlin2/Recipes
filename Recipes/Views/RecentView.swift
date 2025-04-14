//
//  Recents.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import SwiftUI
import SwiftData

struct RecentsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\RecentRecipe.viewedAt, order: .reverse)]) var recentRecipes: [RecentRecipe]
    @State var recipeViewModel = RecipeViewModel()
    @State private var showDeleteConfirmation = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(recentRecipes) { recent in
                    if let recipe = recipeViewModel.recipes.first(where: { $0.uuid == recent.uuid }) {
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeListRow(recipe: recipe)
                        }
                    } else {
                        Text("Recipe unavailable")
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: deleteRecents)
            }
            .navigationTitle("Recently Viewed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(role: .destructive) {
                        showDeleteConfirmation = true
                    } label: {
                        Label("Delete History", systemImage: "trash")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.red)
                    }
                }
            }
            .confirmationDialog("Are you sure you want to delete all recent history?",
                                isPresented: $showDeleteConfirmation,
                                titleVisibility: .visible) {
                Button("Delete All", role: .destructive) {
                    clearAllHistory()
                }
                Button("Cancel", role: .cancel) {}
            }
            .onAppear {
                recipeViewModel.loadRecipes()
            }
        }
    }

    private func deleteRecents(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(recentRecipes[index])
        }
    }

    private func clearAllHistory() {
        for item in recentRecipes {
            modelContext.delete(item)
        }
    }
}
