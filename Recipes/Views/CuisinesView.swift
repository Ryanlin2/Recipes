//
//  CuisinesView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import SwiftUI

struct CuisinesView: View {
    @State var recipeViewModel = RecipeViewModel()
    
    var cuisines: [String] {
        recipeViewModel.cuisines
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Cuisines")
                    .font(.largeTitle)
                    .padding(.top)
                
                GeometryReader { geometry in
                    let isLandscape = geometry.size.width > geometry.size.height
                    let isPad = UIDevice.current.userInterfaceIdiom == .pad
                    let columns = isLandscape ? (isPad ? 4 : 3) : (isPad ? 3 : 2)
                    let gridItems = Array(repeating: GridItem(.flexible()), count: columns)

                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 16) {
                            ForEach(cuisines, id: \.self) { cuisine in
                                NavigationLink(
                                    destination: CuisineDetailView(
                                        cuisine: cuisine,
                                        recipes: recipeViewModel.getCuisine(cuisine)
                                    )
                                ) {
                                    Text(cuisine)
                                        .frame(height: 100)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                recipeViewModel.loadRecipes()
            }
        }
    }
}
