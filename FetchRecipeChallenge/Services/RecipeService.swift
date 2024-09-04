//
//  RecipeService.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import Foundation

class RecipeService {
    private let baseURL = "themealdb.com"
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    private func makeURL(path: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    func fetchRecipes(category: RecipeCategory = .dessert) async -> Result<[Recipe], Error> {
        guard let url = makeURL(path: "/api/json/v1/1/filter.php", queryItems: [URLQueryItem(name: "c", value: category.rawValue)]) else {
            return .failure(NetworkError.invalidURL)
        }
        
        do {
            let root: Root = try await networkService.request(url.absoluteString, method: "GET", headers: nil, body: nil)
            let recipes = root.meals.map { Recipe(decodedRecipe: $0) }
            return .success(recipes)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchRecipe(recipeId: String) async -> Result<Recipe, Error> {
        guard let url = makeURL(path: "/api/json/v1/1/lookup.php", queryItems: [URLQueryItem(name: "i", value: recipeId)]) else {
            return .failure(NetworkError.invalidURL)
        }
        
        do {
            let root: Root = try await networkService.request(url.absoluteString, method: "GET", headers: nil, body: nil)
            guard let firstMeal = root.meals.first else {
                return .failure(NetworkError.noData)
            }
            return .success(Recipe(decodedRecipe: firstMeal))
        } catch {
            return .failure(error)
        }
    }
}
