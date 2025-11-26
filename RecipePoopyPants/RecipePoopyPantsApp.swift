//
//  RecipePoopyPantsApp.swift
//  RecipePoopyPants
//
//  Created by Mike Brockman on 11/20/25.
//

import SwiftUI
import SwiftData

// public static void main ;)
@main
struct RecipePoopyPantsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Recipe.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // Scene is sort of equivalent to the browser window, in that the whole app
    // needs to be mounted in a Scene
    var body: some Scene {
        WindowGroup {
            ContentView() // your main attach point for subsequent views
        }
        .modelContainer(sharedModelContainer)
    }
}
