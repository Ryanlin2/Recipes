//
//  CuisineDetailView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import Foundation

import SwiftUI

struct CuisineDetailView: View {
    let cuisine: String
    let recipes: [Recipe]

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(cuisine) Recipes")
                .font(.largeTitle)
                .padding(.horizontal)

            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(recipes) { recipe in
                        RecipeCard(recipe: recipe)
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle(cuisine)
        .navigationBarTitleDisplayMode(.inline)
    }
}
