//
//  MealDetail.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import Foundation

struct MealDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    
    private let strIngredient1: String?
    private let strIngredient2: String?
    private let strIngredient3: String?
    private let strIngredient4: String?
    private let strIngredient5: String?
    private let strIngredient6: String?
    private let strIngredient7: String?
    private let strIngredient8: String?
    private let strIngredient9: String?
    private let strIngredient10: String?
    private let strMeasure1: String?
    private let strMeasure2: String?
    private let strMeasure3: String?
    private let strMeasure4: String?
    private let strMeasure5: String?
    private let strMeasure6: String?
    private let strMeasure7: String?
    private let strMeasure8: String?
    private let strMeasure9: String?
    private let strMeasure10: String?
    
    var ingredients: [String] {
        let ingredientsList = [
            (strIngredient1, strMeasure1),
            (strIngredient2, strMeasure2),
            (strIngredient3, strMeasure3),
            (strIngredient4, strMeasure4),
            (strIngredient5, strMeasure5),
            (strIngredient6, strMeasure6),
            (strIngredient7, strMeasure7),
            (strIngredient8, strMeasure8),
            (strIngredient9, strMeasure9),
            (strIngredient10, strMeasure10)
        ]
        
        return ingredientsList.compactMap {
            guard let ingredient = $0.0, !ingredient.isEmpty else { return nil }
            let measure = $0.1 ?? ""
            return "\(ingredient) - \(measure)"
        }
    }
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
