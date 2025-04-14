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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(savedItems) { saved in
                    NavigationLink(destination: SavedRecipeDetailView(savedRecipe: saved)) {
                        HStack(spacing: 16) {
                            if let urlStr = saved.photoURL, let url = URL(string: urlStr) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipped()
                                            .cornerRadius(8)
                                    default:
                                        Color.gray
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(8)
                                    }
                                }
                            } else {
                                Color.gray
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(8)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(saved.name)
                                    .font(.headline)
                                Text(saved.cuisine)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(perform: deleteSaved)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Saved Recipes")
            .toolbar {
                EditButton()
            }
        }
    }
    
    private func deleteSaved(at offsets: IndexSet) {
        for index in offsets {
            let saved = savedItems[index]
            modelContext.delete(saved)
        }
    }
}

struct SavedRecipeDetailView: View {
    let savedRecipe: SavedRecipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let urlStr = savedRecipe.photoURL, let url = URL(string: urlStr) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        default:
                            Color.gray
                                .frame(height: 200)
                        }
                    }
                }
                Text(savedRecipe.name)
                    .font(.title)
                    .bold()
                Text("Cuisine: \(savedRecipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
        }
        .navigationTitle(savedRecipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
