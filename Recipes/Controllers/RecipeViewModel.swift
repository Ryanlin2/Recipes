//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Ryan Lin on 4/11/25.
// 

import Foundation

@Observable
class RecipeViewModel{
    var recipes: [Recipe] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var cuisines: [String] = []
    var recipesByCuisine: [[Recipe]] = []
    

    func loadRecipes() {
        isLoading = true
        NetworkManager.shared.fetchRecipes { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let recipes):
                    self?.recipes = recipes
                    self?.loadCuisines()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    func loadCuisines() {
        cuisines = []
        recipesByCuisine = []

        var cuisineSet: Set<String> = []

        for recipe in recipes {
            if !cuisineSet.contains(recipe.cuisine) {
                cuisineSet.insert(recipe.cuisine)
                cuisines.append(recipe.cuisine)
            }
        }

        recipesByCuisine = cuisines.map { cuisine in
            recipes.filter { $0.cuisine == cuisine }
        }

        print("Cuisines:", cuisines)
        print("Recipes by Cuisine:", recipesByCuisine)
    }
}
