//
//  Meal.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String { idMeal }
}

struct MealResponse: Decodable {
    let meals: [Meal]
}


