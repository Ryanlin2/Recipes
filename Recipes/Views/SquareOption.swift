//
//  SquareOption.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import SwiftUI

struct SquareOption: View {
    let title: String
    let icon: String
    let geometry: GeometryProxy  // 👈 Pass in from parent

    var body: some View {
        let isLandscape = geometry.size.width > geometry.size.height
        let height: CGFloat = isLandscape ? 200 : 300

        VStack(spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .foregroundColor(.blue)
            
            

            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, minHeight: height)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
