//
//  ContentView.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
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
            .environment(\.managedObjectContext, viewContext)
    }
}
