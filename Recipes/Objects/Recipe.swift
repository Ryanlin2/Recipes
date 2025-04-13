//
//  Recipe.swift
//  Recipes
//
//  Created by Ryan Lin on 4/12/25.
//

import Foundation

struct Recipe: Codable, Identifiable {
    var id: String { uuid }

    let cuisine: String
    let name: String
    let uuid: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name, uuid
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
