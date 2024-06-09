//
//  RecipesListView.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import Foundation
import SwiftUI

struct RecipesListView: View {
    @State private var meals: [Meal] = []
    @State private var isLoading = true
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: FavoriteDessert.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteDessert.strMeal, ascending: true)]
    ) var favoriteDesserts: FetchedResults<FavoriteDessert>
    
    var body: some View {
        ZStack {
            VStack {
                List(meals.sorted(by: { $0.strMeal < $1.strMeal })) { meal in
                    NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                        HStack {
                            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                            Text(meal.strMeal)
                                .font(.headline)
                                .foregroundColor(.darkGreen)
                        }
                    }
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Dessert Recipes")
                .font(.custom("Avenir", size: 18))
                .onAppear(perform: fetchMeals)
                .background(Color.clear)
                
                if !favoriteDesserts.isEmpty {
                    VStack {
                        Text("Favorites")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.darkGreen)
                            .padding(.top)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(favoriteDesserts) { favorite in
                                    NavigationLink(destination: MealDetailView(mealID: favorite.idMeal ?? "")) {
                                        VStack {
                                            AsyncImage(url: URL(string: favorite.strMealThumb ?? "")) { image in
                                                image.resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 100, height: 100)
                                                    .cornerRadius(8)
                                                    .clipped()
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 100, height: 100)
                                            }
                                            Text(favorite.strMeal ?? "")
                                                .font(.caption)
                                                .foregroundColor(.darkGreen)
                                        }
                                        .padding()
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.gray.opacity(0.05))
                }
            }

            if isLoading {
                ProgressView("Loading...")
                    .scaleEffect(1.5, anchor: .center)
            }
        }
    }
    
    private func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let mealResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.meals = mealResponse.meals.filter { !$0.strMeal.isEmpty }
                        self.isLoading = false
                    }
                }
            }
        }.resume()
    }
}
