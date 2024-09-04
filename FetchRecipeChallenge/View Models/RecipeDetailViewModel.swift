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
    var showErrorText: Bool = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func fetchFullRecipe() async {
        let result = await recipeService.fetchRecipe(recipeId: recipe.id ?? "")
        switch result {
        case .success(let recipe):
            self.recipe = recipe
            errorText = ""
            showErrorText = false
        case .failure(let error as NetworkError):
            errorText = error.errorMessage
        case .failure(let error):
            errorText = "General error occurred: \(error.localizedDescription)"
        }
        if !errorText.isEmpty {
            showErrorText = true
        }
    }
}
