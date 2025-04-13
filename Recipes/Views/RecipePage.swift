//
//  RecipePage.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import Foundation

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Recipe image
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

                // Recipe info
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Cuisine: \(recipe.cuisine)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()

                if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL) {
                    Link("View Source", destination: url)
                        .foregroundColor(.blue)
                }

                if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                    Link("Watch on YouTube", destination: url)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
