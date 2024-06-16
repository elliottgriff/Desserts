//
//  recipesApp.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import SwiftUI

@main
struct RecipesApp: App {
    @StateObject var api: RecipeAPI = RecipeAPI()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(api)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
