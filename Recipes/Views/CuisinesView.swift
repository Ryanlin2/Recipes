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
                                    Text("\(cuisine) \(cuisine.flagEmoji)")
                                        .foregroundColor(.black)
                                        .frame(height: 100)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )

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
