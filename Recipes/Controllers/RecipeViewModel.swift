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
    func loadCuisines(){
        for recipe in recipes{
            if !cuisines.contains(recipe.cuisine){
                cuisines.append(recipe.cuisine)
            }
        }
        print(cuisines)
    }
}
