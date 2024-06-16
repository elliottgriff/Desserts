//
//  Meal.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import Foundation

public final class Meal: Codable, Identifiable, Hashable {
    public let idMeal: String
    public let strMeal: String
    public let strMealThumb: String
    
    public var id: String { idMeal }
    
    public init(idMeal: String, strMeal: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
    
    public enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strMealThumb
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strMealThumb, forKey: .strMealThumb)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
    }
    
    public static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.idMeal == rhs.idMeal &&
        lhs.strMeal == rhs.strMeal &&
        lhs.strMealThumb == rhs.strMealThumb
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(idMeal)
        hasher.combine(strMeal)
        hasher.combine(strMealThumb)
    }
}

public struct MealResponse: Codable {
    public let meals: [Meal]
}
