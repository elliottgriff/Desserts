//
//  recipesApp.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import SwiftUI

@main
struct recipesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
