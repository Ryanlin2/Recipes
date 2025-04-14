//
//  SearchResultRow.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import Foundation

import SwiftUI

struct SearchResultRow: View {
    let recipe: Recipe

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            AsyncImage(url: URL(string: recipe.photoURLSmall ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Color.gray
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                        .overlay(Text("No Image").font(.caption).foregroundColor(.white))
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}
