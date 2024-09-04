//
//  ContentViewModel.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import Foundation

@Observable
class ContentViewModel {
    var errorText: String = ""
    var showErrorText: Bool = false
    var recipes = [Recipe]()
    private let recipeService = RecipeService()
    
    func fetchRecipes() async {
        let result = await recipeService.fetchRecipes()
        switch result {
        case .success(let recipes):
            self.recipes = recipes.sorted { $0.name < $1.name }
            errorText = ""
            showErrorText = false
        case .failure(let error as NetworkError):
            errorText = error.errorMessage
        case .failure(let error):
            errorText = "General error occurred: \(error.localizedDescription)"
        }
        if !errorText.isEmpty && recipes.isEmpty {
            showErrorText = true
        }
    }
}
