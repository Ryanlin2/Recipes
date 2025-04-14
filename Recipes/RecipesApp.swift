//
//  RecipesApp.swift
//  Recipes
//
//  Created by Ryan Lin on 4/11/25.
//

import SwiftUI
import SwiftData

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            HomepageView()
        }
        .modelContainer(for: [SavedRecipe.self, FavoriteRecipe.self])
    }
}
