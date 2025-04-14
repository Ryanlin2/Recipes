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

    var body: some View {
        NavigationStack {
            List {
                ForEach(favoriteItems) { favorite in
                    NavigationLink(destination: FavoriteRecipeDetailView(favorite: favorite)) {
                        HStack(spacing: 16) {
                            if let urlStr = favorite.photoURL, let url = URL(string: urlStr) {
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
                                Text(favorite.name)
                                    .font(.headline)
                                Text(favorite.cuisine)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .onDelete(perform: deleteFavorites)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Favorite Recipes")
            .toolbar {
                EditButton()
            }
        }
    }

    private func deleteFavorites(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(favoriteItems[index])
        }
    }
}

struct FavoriteRecipeDetailView: View {
    let favorite: FavoriteRecipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = URL(string: favorite.photoURL ?? "") {
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
                            Color.gray.frame(height: 200)
                        }
                    }
                }

                Text(favorite.name)
                    .font(.title)
                    .bold()

                Text("Cuisine: \(favorite.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(favorite.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


