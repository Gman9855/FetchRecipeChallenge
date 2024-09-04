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
    var showErrorText: Bool {
        !errorText.isEmpty
    }
    var recipes = [Recipe]()
    private let recipeService = RecipeService()
    
    func fetchRecipes() async {
        do {
            self.recipes = try await recipeService.fetchRecipes().sorted { $0.name < $1.name }
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
//        if !errorText.isEmpty {
//            showErrorText = true
//        }
    }
}
