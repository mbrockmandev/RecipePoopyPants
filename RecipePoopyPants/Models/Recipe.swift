//
//  Item.swift
//  RecipePoopyPants
//
//  Created by Mike Brockman on 11/20/25.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var timestamp: Date
    var title: String
    
    init(timestamp: Date, title: String) {
        self.timestamp = timestamp
        self.title = title
    }
}
