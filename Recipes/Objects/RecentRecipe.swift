//
//  RecentRecipe.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import Foundation
import SwiftData

@Model
class RecentRecipe: Identifiable {
    var uuid: String
    var name: String
    var cuisine: String
    var photoURL: String?
    var viewedAt: Date

    init(uuid: String, name: String, cuisine: String, photoURL: String? = nil, viewedAt: Date = .now) {
        self.uuid = uuid
        self.name = name
        self.cuisine = cuisine
        self.photoURL = photoURL
        self.viewedAt = viewedAt
    }
}
