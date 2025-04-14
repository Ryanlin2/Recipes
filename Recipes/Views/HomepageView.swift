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
                        
                        // Display Search Results if text entered, else show grid
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
                            // Responsive 4-Option Grid with your updated icons/colors.
                            LazyVGrid(columns: gridItems, spacing: 16) {
                                SquareOption(title: "Saved", icon: "bookmark.fill", geometry: geometry) {
                                    selectedPage = .saved
                                }
                                SquareOption(title: "Explore", icon: "fork.knife", geometry: geometry, iconColor: .green) {
                                    selectedPage = .explore
                                }
                                SquareOption(title: "Recents", icon: "clock", geometry: geometry, iconColor: .gray) {
                                    selectedPage = .recents
                                }
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
            // Navigation destinations for each tile.
            .navigationDestination(item: $selectedPage) { page in
                switch page {
                case .saved:
                    SavedRecipesView()
                case .explore:
                    CuisinesView()
                case .recents:
                    Text("Recents View Coming Soon") // placeholder view
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
