//
//  MealDetail.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import Foundation

public final class MealDetail: Codable, Hashable {
    public let idMeal: String
    public let strMeal: String
    public let strInstructions: String
    public let strMealThumb: String

    private var dynamicValues: [String: String?] = [:]
    
    public var ingredients: [String] {
        var ingredientsList: [String] = []
        
        var index = 1
        while let ingredient = dynamicValues["strIngredient\(index)"] as? String, !ingredient.isEmpty {
            let measure = dynamicValues["strMeasure\(index)"] as? String ?? ""
            ingredientsList.append("\(ingredient) - \(measure)")
            index += 1
        }
        
        return ingredientsList
    }

    private enum StaticCodingKeys: String, CodingKey, CaseIterable {
        case idMeal, strMeal, strInstructions, strMealThumb
    }

    public init(idMeal: String, strMeal: String, strInstructions: String, strMealThumb: String, dynamicValues: [String: String?]) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.dynamicValues = dynamicValues
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StaticCodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for key in dynamicContainer.allKeys {
            if key.stringValue.hasPrefix("strIngredient") || key.stringValue.hasPrefix("strMeasure") {
                let value = try dynamicContainer.decodeIfPresent(String.self, forKey: key)
                dynamicValues[key.stringValue] = value
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StaticCodingKeys.self)
        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strInstructions, forKey: .strInstructions)
        try container.encode(strMealThumb, forKey: .strMealThumb)
        
        var dynamicContainer = encoder.container(keyedBy: DynamicCodingKeys.self)
        for (key, value) in dynamicValues {
            try dynamicContainer.encodeIfPresent(value, forKey: DynamicCodingKeys(stringValue: key)!)
        }
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? {
            return nil
        }
        
        init?(intValue: Int) {
            return nil
        }
    }

    public static func == (lhs: MealDetail, rhs: MealDetail) -> Bool {
        lhs.idMeal == rhs.idMeal &&
        lhs.strMeal == rhs.strMeal &&
        lhs.strInstructions == rhs.strInstructions &&
        lhs.strMealThumb == rhs.strMealThumb &&
        lhs.dynamicValues == rhs.dynamicValues
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(idMeal)
        hasher.combine(strMeal)
        hasher.combine(strInstructions)
        hasher.combine(strMealThumb)
        hasher.combine(dynamicValues)
    }
}

public struct MealDetailResponse: Codable {
    public let meals: [MealDetail]
}
