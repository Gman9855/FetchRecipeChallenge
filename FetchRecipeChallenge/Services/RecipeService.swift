//
//  RecipeService.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import Foundation

class RecipeService {
    private let BASE_URL = "themealdb.com"
    private let networkService = NetworkService()
    
    func fetchRecipes(category: RecipeCategory = .dessert) async throws -> [Recipe] {
        var components = URLComponents()
        components.scheme = "https"
        components.host = BASE_URL
        components.path = "/api/json/v1/1/filter.php"
        components.queryItems = [
            URLQueryItem(name: "c", value: category.rawValue),
        ]
        
        let root: Root = try await networkService.request(components.url?.absoluteString ?? "")
        return root.meals
    }
    
    func fetchRecipe(recipeId: String) async throws -> Recipe {
        var components = URLComponents()
        components.scheme = "https"
        components.host = BASE_URL
        components.path = "/api/json/v1/1/lookup.php"
        components.queryItems = [
            URLQueryItem(name: "i", value: recipeId),
        ]
        
        let root: Root = try await networkService.request(components.url?.absoluteString ?? "")
        return root.meals.first!
    }
}
