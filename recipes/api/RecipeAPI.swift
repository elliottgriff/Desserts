//
//  RecipeAPI.swift
//  recipes
//
//  Created by Elliott Griffin on 6/16/24.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case url
    case server
}

@MainActor
class RecipeAPI: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoadingDetail = true
    @Published var meals: [Meal] = []
    @Published var isLoadingMeals = true

    func fetchMealDetails(mealID: String) async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let mealDetailResponse = try? JSONDecoder().decode(MealDetailResponse.self, from: data) {
                self.mealDetail = mealDetailResponse.meals.first
            }
        } catch {
            throw NetworkError.server
        }
        self.isLoadingDetail = false
    }
    
    func fetchMeals(category: String) async throws {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let mealResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                self.meals = mealResponse.meals.filter { !$0.strMeal.isEmpty }
            }
        } catch {
            throw NetworkError.server
        }
        self.isLoadingMeals = false
    }
}


