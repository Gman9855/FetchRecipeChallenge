//
//  Dish.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import Foundation

enum RecipeCategory: String, Codable {
    case dessert = "Dessert"
    // add other categories here
}

struct Root: Codable {
    var meals: [RawDecodedRecipe]
}

struct MeasuredIngredient: Identifiable {
    let id = UUID()
    let ingredient: String
    let measurement: String
}

struct Recipe: Identifiable {
    var id: String?
    var name: String
    var imageUrl: String
    var drinkAlternate: String?
    var category: RecipeCategory?
    var area: String?
    var instructions: String?
    var tags: String?
    var youtubeUrl: String?
    var source: String?
    var imageSource: String?
    var creativeCommonsConfirmed: String?
    var dateModified: String?
    var measuredIngredients: [MeasuredIngredient]
    
    init(id: String, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.measuredIngredients = []
    }
    
    init(decodedRecipe: RawDecodedRecipe) {
        self.id = decodedRecipe.idMeal
        self.name = decodedRecipe.strMeal
        self.imageUrl = decodedRecipe.strMealThumb
        self.drinkAlternate = decodedRecipe.strDrinkAlternate
        self.category = decodedRecipe.strCategory
        self.area = decodedRecipe.strArea
        self.instructions = decodedRecipe.strInstructions
        self.tags = decodedRecipe.strTags
        self.youtubeUrl = decodedRecipe.strYoutube
        self.source = decodedRecipe.strSource
        self.imageSource = decodedRecipe.strImageSource
        self.creativeCommonsConfirmed = decodedRecipe.strCreativeCommonsConfirmed
        self.dateModified = decodedRecipe.dateModified
        
        var res = [(String?, String?)]()
        res.append((decodedRecipe.strIngredient1, decodedRecipe.strMeasure1))
        res.append((decodedRecipe.strIngredient2, decodedRecipe.strMeasure2))
        res.append((decodedRecipe.strIngredient3, decodedRecipe.strMeasure3))
        res.append((decodedRecipe.strIngredient4, decodedRecipe.strMeasure4))
        res.append((decodedRecipe.strIngredient5, decodedRecipe.strMeasure5))
        res.append((decodedRecipe.strIngredient6, decodedRecipe.strMeasure6))
        res.append((decodedRecipe.strIngredient7, decodedRecipe.strMeasure7))
        res.append((decodedRecipe.strIngredient8, decodedRecipe.strMeasure8))
        res.append((decodedRecipe.strIngredient9, decodedRecipe.strMeasure9))
        res.append((decodedRecipe.strIngredient10, decodedRecipe.strMeasure10))
        res.append((decodedRecipe.strIngredient11, decodedRecipe.strMeasure11))
        res.append((decodedRecipe.strIngredient12, decodedRecipe.strMeasure12))
        res.append((decodedRecipe.strIngredient13, decodedRecipe.strMeasure13))
        res.append((decodedRecipe.strIngredient14, decodedRecipe.strMeasure14))
        res.append((decodedRecipe.strIngredient15, decodedRecipe.strMeasure15))
        res.append((decodedRecipe.strIngredient16, decodedRecipe.strMeasure16))
        res.append((decodedRecipe.strIngredient17, decodedRecipe.strMeasure17))
        res.append((decodedRecipe.strIngredient18, decodedRecipe.strMeasure18))
        res.append((decodedRecipe.strIngredient19, decodedRecipe.strMeasure19))
        res.append((decodedRecipe.strIngredient20, decodedRecipe.strMeasure20))

        self.measuredIngredients = res.compactMap { val in
            if let ingredient = val.0?.trimmingCharacters(in: .whitespacesAndNewlines), 
                let measure = val.1?.trimmingCharacters(in: .whitespacesAndNewlines),
                !ingredient.isEmpty, !measure.isEmpty {
                return MeasuredIngredient(ingredient: ingredient, measurement: measure)
            } else {
                return nil
            }
        }
    }
}

struct RawDecodedRecipe: Codable {
    var idMeal: String?
    var strMeal: String
    var strMealThumb: String
    var strDrinkAlternate: String?
    var strCategory: RecipeCategory?
    var strArea: String?
    var strInstructions: String?
    var strTags: String?
    var strYoutube: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    var strSource: String?
    var strImageSource: String?
    var strCreativeCommonsConfirmed: String?
    var dateModified: String?
}
