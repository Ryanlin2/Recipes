//
//  RecipeView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/11/25.
//

import Foundation
import SwiftUI

struct HomepageView: View {
    @State var viewModel = RecipeViewModel()
    @State private var searchText = ""
    
    enum HomeNavigation: Hashable {
        case saved
        case explore
        case recents
        case favorites
    }
    
    @State private var selectedPage: HomeNavigation?
    
    var filteredRecipes: [Recipe] {
        viewModel.recipes.filter {
            searchText.isEmpty ? false : (
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.cuisine.localizedCaseInsensitiveContains(searchText)
            )
        }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let isLandscape = geometry.size.width > geometry.size.height
                let columns = isLandscape ? 4 : 2
                let gridItems = Array(repeating: GridItem(.flexible()), count: columns)
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Title
                        Text("Recipes App")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                        
                        // Search Bar with Clear Button
                        HStack {
                            TextField("Search Recipes", text: $searchText)
                                .padding(10)
                            
                            if !searchText.isEmpty {
                                Button(action: {
                                    searchText = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        if !isLandscape {
                            Spacer().frame(height: 20)
                        }
                        
                        // Display Search Results if text entered
                        if !searchText.isEmpty {
                            if filteredRecipes.isEmpty {
                                Text("No results found.")
                                    .foregroundColor(.gray)
                                    .padding()
                            } else {
                                VStack(spacing: 12) {
                                    ForEach(filteredRecipes) { recipe in
                                        SearchResultRow(recipe: recipe)
                                            .padding(.horizontal)
                                    }
                                }
                                .padding()
                            }
                        } else {
                            // Responsive 4-Option Grid
                            LazyVGrid(columns: gridItems, spacing: 16) {
                                // "Saved" uses a bookmark icon.
                                SquareOption(title: "Saved", icon: "bookmark", geometry: geometry) {
                                    selectedPage = .saved
                                }
                                // "Explore" remains the same.
                                SquareOption(title: "Explore", icon: "magnifyingglass", geometry: geometry) {
                                    selectedPage = .explore
                                }
                                // "Recents" placeholder.
                                SquareOption(title: "Recents", icon: "clock", geometry: geometry) {
                                    selectedPage = .recents
                                }
                                // "Favorites" uses a filled heart icon, colored red.
                                SquareOption(title: "Favorites", icon: "heart.fill", geometry: geometry, iconColor: .red) {
                                    selectedPage = .favorites
                                }
                            }
                            .padding()
                        }
                        
                        Spacer(minLength: 20)
                    }
                    .padding(.bottom)
                    .onAppear {
                        viewModel.loadRecipes()
                    }
                }
            }
            // Navigation destinations using enum routing.
            .navigationDestination(item: $selectedPage) { page in
                switch page {
                case .saved:
                    SavedRecipesView()
                case .explore:
                    CuisinesView()
                case .recents:
                    Text("Recents View Coming Soon")
                case .favorites:
                    FavoriteRecipesView()
                }
            }
        }
    }
}

#Preview {
    HomepageView()
}




#Preview {
    HomepageView()
}
