//
//  FavoriteRecipe.swift
//  Recipes
//
//  Created by Ryan Lin on 4/14/25.
//

import Foundation
import SwiftData

@Model
class FavoriteRecipe{
    var uuid:String
    var name:String
    var cuisine:String
    var photoURL:String?
    
    init(uuid:String,name:String,cuisine:String,photoURL:String?=nil){
        self.uuid = uuid
        self.name = name
        self.cuisine = cuisine
        if let photoURL = photoURL{
            self.photoURL = photoURL
        }
    }
}
