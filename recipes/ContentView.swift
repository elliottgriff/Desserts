//
//  ContentView.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var api: RecipeAPI
    
    var body: some View {
        NavigationView {
            LandingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let viewContext = PersistenceController.preview.container.viewContext
    
    static var previews: some View {
        ContentView()
            .environmentObject(RecipeAPI())
            .environment(\.managedObjectContext, viewContext)
    }
}
