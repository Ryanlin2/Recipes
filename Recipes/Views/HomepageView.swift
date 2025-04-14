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
    @State private var showCuisines = false


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

                        // Search Bar
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

                        // Optional vertical spacing (only in portrait)
                        if !isLandscape {
                            Spacer().frame(height: 20)
                        }

                        // Search Results
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
                                SquareOption(title: "Pinned", icon: "pin", geometry: geometry)
                                SquareOption(title: "Explore", icon: "magnifyingglass", geometry: geometry) {
                                    showCuisines = true
                                    }
                                SquareOption(title: "Recents", icon: "clock", geometry: geometry)
                                SquareOption(title: "Saved", icon: "bookmark", geometry: geometry)
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
                .navigationDestination(isPresented: $showCuisines) {
                    CuisinesView()
                }
            }
        }
    }
    
}


#Preview {
    HomepageView()
}
