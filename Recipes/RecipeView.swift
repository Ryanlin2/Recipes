//
//  RecipeView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/11/25.
//

import Foundation
import SwiftUI

struct RecipeView: View {
    @State var viewModel = RecipeViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.recipes) { recipe in
                VStack(alignment: .leading) {
                    Text(recipe.name).font(.headline)
                    Text(recipe.cuisine).font(.subheadline)
                }
            }
            .navigationTitle("Recipes")
            .onAppear {
                viewModel.loadRecipes()
            }
        }
    }
}
