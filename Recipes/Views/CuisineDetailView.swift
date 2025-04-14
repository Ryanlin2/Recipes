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
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let columns = isLandscape ? 3 : 2
            let gridItems = Array(repeating: GridItem(.flexible(), spacing: 16), count: columns)

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("\(cuisine) \(cuisine.flagEmoji)")
                        .font(.largeTitle)
                        .padding(.horizontal)


                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCard(recipe: recipe)
                                    .frame(width: 180, height: 240)
                            }
                        }
                    }

                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle(cuisine)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
