//
//  CuisineOptionView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import Foundation
import SwiftUI

extension String {
    var flagEmoji: String {
        switch self.lowercased() {
        case "american":
            return "🇺🇸"
        case "british":
            return "🇬🇧"
        case "canadian":
            return "🇨🇦"
        case "croatian":
            return "🇭🇷"
        case "french":
            return "🇫🇷"
        case "greek":
            return "🇬🇷"
        case "italian":
            return "🇮🇹"
        case "malaysian":
            return "🇲🇾"
        case "polish":
            return "🇵🇱"
        case "portuguese":
            return "🇵🇹"
        case "russian":
            return "🇷🇺"
        case "tunisian":
            return "🇹🇳"
        default:
            return ""
        }
    }
}

struct CuisineOptionView: View {
    let cuisine: String
    
    var body: some View {
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

#Preview {
    CuisineOptionView(cuisine: "Italian")
}
