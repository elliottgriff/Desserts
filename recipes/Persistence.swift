//
//  Persistence.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let favoriteDessert = FavoriteDessert(context: viewContext)
        favoriteDessert.idMeal = "52772"
        favoriteDessert.strMeal = "Teriyaki Chicken Casserole"
        favoriteDessert.strMealThumb = "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg"
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FavoriteDessert")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
