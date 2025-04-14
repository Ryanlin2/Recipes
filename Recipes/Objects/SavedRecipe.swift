//
//  SavedRecipe.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import SwiftData

@Model
class SavedRecipe: Identifiable {
    var uuid: String
    var name: String
    var cuisine: String
    var photoURL: String?

    init(uuid: String, name: String, cuisine: String, photoURL: String? = nil) {
        self.uuid = uuid
        self.name = name
        self.cuisine = cuisine
        self.photoURL = photoURL
    }
}
