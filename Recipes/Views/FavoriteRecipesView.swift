//
//  FavoriteRecipesView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import SwiftUI
import SwiftData

struct FavoriteRecipesView: View {
    @Query var favorites: [FavoriteRecipe]
    
    var body: some View {
        List {
            ForEach(favorites) { fav in
                HStack {
                    if let url = fav.photoURL, let imageURL = URL(string: url) {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(6)
                            default:
                                Color.gray.frame(width: 50, height: 50)
                            }
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(fav.name).font(.headline)
                        Text(fav.cuisine).font(.subheadline).foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("Favorite Recipes")
    }
}

