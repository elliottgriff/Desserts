//
//  MealDetailView.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @EnvironmentObject var api: RecipeAPI
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: FavoriteDessert.entity(),
        sortDescriptors: []
    ) var favoriteDesserts: FetchedResults<FavoriteDessert>
    
    var isFavorited: Bool {
        favoriteDesserts.contains { $0.idMeal == mealID }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let mealDetail = api.mealDetail {
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .cornerRadius(10)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    }
                    
                    Text(mealDetail.strMeal)
                        .font(.custom("Avenir-Heavy", size: 32))
                        .foregroundColor(.darkGreen)
                        .padding(.top)
                    
                    Button(action: toggleFavorite) {
                        HStack {
                            Image(systemName: isFavorited ? "heart.fill" : "heart")
                            Text(isFavorited ? "Remove from Favorites" : "Add to Favorites")
                        }
                        .foregroundColor(.darkGreen)
                    }
                    
                    Text("Ingredients")
                        .font(.custom("Avenir-Medium", size: 24))
                        .foregroundColor(.darkGreen)
                        .padding(.top)
                    
                    ForEach(mealDetail.ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                            .font(.custom("Avenir-Light", size: 18))
                            .foregroundColor(.darkGreen)
                            .padding(.vertical, 2)
                    }
                    
                    Text("Instructions")
                        .font(.custom("Avenir-Medium", size: 24))
                        .foregroundColor(.darkGreen)
                        .padding(.top)
                    
                    Text(mealDetail.strInstructions)
                        .font(.custom("Avenir-Light", size: 18))
                        .foregroundColor(.darkGreen)
                    
                } else if api.isLoadingDetail {
                    ProgressView("Loading...")
                        .scaleEffect(1.5, anchor: .center)
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
        .onAppear(perform: {
            Task {
                try await api.fetchMealDetails(mealID: mealID)
            }
        })
    }
    
    private func toggleFavorite() {
        if isFavorited {
            removeFavorite()
        } else {
            addFavorite()
        }
    }
    
    private func addFavorite() {
        guard let mealDetail = api.mealDetail else { return }
        let favorite = FavoriteDessert(context: viewContext)
        favorite.idMeal = mealDetail.idMeal
        favorite.strMeal = mealDetail.strMeal
        favorite.strMealThumb = mealDetail.strMealThumb
        saveContext()
    }
    
    private func removeFavorite() {
        if let favorite = favoriteDesserts.first(where: { $0.idMeal == mealID }) {
            viewContext.delete(favorite)
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.localizedDescription)")
        }
    }
}
