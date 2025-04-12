//
//  CuisineOptionView.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import Foundation
import SwiftUI

struct CuisineOptionView : View {
    let cuisine:String
    
    var body: some View {
        Text("\(cuisine)")
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
    }
}
 
#Preview {
    CuisineOptionView(cuisine: "Italian")
}
