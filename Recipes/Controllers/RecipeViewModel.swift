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
        var cuisineSet: Set<String> = []

        for recipe in recipes {
            cuisineSet.insert(recipe.cuisine)
        }

        cuisines = cuisineSet.sorted()

        recipesByCuisine = cuisines.map { cuisine in
            recipes.filter { $0.cuisine == cuisine }
        }

        print("Cuisines:", cuisines)
        print("Recipes by Cuisine:", recipesByCuisine)

    }
    
    func getCuisine(_ cuisine: String) -> [Recipe] {
        guard cuisines.contains(cuisine) else { return [] }
        return recipes.filter { $0.cuisine == cuisine }
    }

}

