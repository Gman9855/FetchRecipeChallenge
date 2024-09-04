//
//  Dish.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import Foundation

enum RecipeCategory: String, Codable {
    case dessert = "Dessert"
    // other categories
}

struct Root: Codable {
    var meals: [Recipe]
}

struct Recipe: Codable, Identifiable, Hashable {
    var id: String?
    var name: String
    var imageUrl: String
    var drinkAlternate: String?
    var category: RecipeCategory?
    var area: String?
    var instructions: String?
    var tags: String?
    var youtubeUrl: String?
    var ingredient1: String?
    var ingredient2: String?
    var ingredient3: String?
    var ingredient4: String?
    var ingredient5: String?
    var ingredient6: String?
    var ingredient7: String?
    var ingredient8: String?
    var ingredient9: String?
    var ingredient10: String?
    var ingredient11: String?
    var ingredient12: String?
    var ingredient13: String?
    var ingredient14: String?
    var ingredient15: String?
    var ingredient16: String?
    var ingredient17: String?
    var ingredient18: String?
    var ingredient19: String?
    var ingredient20: String?
    var measure1: String?
    var measure2: String?
    var measure3: String?
    var measure4: String?
    var measure5: String?
    var measure6: String?
    var measure7: String?
    var measure8: String?
    var measure9: String?
    var measure10: String?
    var measure11: String?
    var measure12: String?
    var measure13: String?
    var measure14: String?
    var measure15: String?
    var measure16: String?
    var measure17: String?
    var measure18: String?
    var measure19: String?
    var measure20: String?
    var source: String?
    var imageSource: String?
    var creativeCommonsConfirmed: String?
    var dateModified: String?
    
    var measuredIngredients: [MeasuredIngredient] {
        var res = [(String?, String?)]()
        res.append((ingredient1, measure1))
        res.append((ingredient2, measure2))
        res.append((ingredient3, measure3))
        res.append((ingredient4, measure4))
        res.append((ingredient5, measure5))
        res.append((ingredient6, measure6))
        res.append((ingredient7, measure7))
        res.append((ingredient8, measure8))
        res.append((ingredient9, measure9))
        res.append((ingredient10, measure10))
        res.append((ingredient11, measure11))
        res.append((ingredient12, measure12))
        res.append((ingredient13, measure13))
        res.append((ingredient14, measure14))
        res.append((ingredient15, measure15))
        res.append((ingredient16, measure16))
        res.append((ingredient17, measure17))
        res.append((ingredient18, measure18))
        res.append((ingredient19, measure19))
        res.append((ingredient20, measure20))

        return  res.compactMap { val in
            if let ingredient = val.0?.trimmingCharacters(in: .whitespacesAndNewlines),
               let measure = val.1?.trimmingCharacters(in: .whitespacesAndNewlines),
               !ingredient.isEmpty,
               !measure.isEmpty {
                    return (ingredient, measure)
                } else {
                    return nil
                }
        }.map { MeasuredIngredient(ingredient: $0.0, measurement: $0.1) }
    }
    var formattedIngredientsList: String {
        return measuredIngredients.reduce("") { partialResult, val in
            partialResult + val.ingredient + "\n\n"
        }
    }
    var formattedMeasurementsList: String {
        return measuredIngredients.reduce("") { partialResult, val in
            partialResult + val.measurement + "\n\n"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageUrl = "strMealThumb"
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case tags = "strTags"
        case youtubeUrl = "strYoutube"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
        case source = "strSource"
        case imageSource = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModified
    }
}

struct MeasuredIngredient: Identifiable {
    let id = UUID()
    let ingredient: String
    let measurement: String
}
