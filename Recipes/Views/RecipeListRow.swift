//
//  RecipeListRow.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import Foundation
import SwiftUI

struct RecipeListRow: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 16) {
            if let url = recipe.photoURLSmall, let imageURL = URL(string: url) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipped()
                            .cornerRadius(8)
                    default:
                        Color.gray.frame(width: 60, height: 60).cornerRadius(8)
                    }
                }
            }
            VStack(alignment: .leading) {
                Text(recipe.name).font(.headline)
                Text(recipe.cuisine).font(.subheadline).foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
