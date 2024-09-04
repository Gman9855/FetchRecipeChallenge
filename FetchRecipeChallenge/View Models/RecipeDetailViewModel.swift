//
//  RecipeDetailViewModel.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import Foundation

@Observable
class RecipeDetailViewModel {
    
    private let recipeService = RecipeService()
    var recipe: Recipe
    var errorText: String = ""
    var showErrorText: Bool {
        !errorText.isEmpty
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func fetchFullRecipe() async {
        do {
            self.recipe = try await recipeService.fetchRecipe(recipeId: recipe.id ?? "")
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                errorText = "Invalid URL"
            case .decodingFailed(let error):
                errorText = "Decoding failed with error: \(error.localizedDescription)"
            case .invalidResponse:
                errorText = "Invalid server response"
            case .unknown(let unknownError):
                errorText = "Unknown error occurred: \(unknownError.localizedDescription)"
            case .requestFailed:
                print("Request failed")
            }
        } catch {
            errorText = "An unexpected error occurred: \(error)"
        }
    }
}
