//
//  ContentView.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()
    var body: some View {
        NavigationStack {
            List(viewModel.recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe))) {
                    HStack {
                        AsyncImage(url: URL(string: recipe.imageUrl)!, content: { img in
                            img.resizable()
                                .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 70)
                            .clipShape(.rect(cornerRadius: 5))
                        }, placeholder: {
                            ProgressView()
                                .frame(width: 70, height: 70)
                        })
                        Text(recipe.name)
                            .font(.headline)
                    }
                }
            }
            .listRowSpacing(8)
            .alert(viewModel.errorText, isPresented: $viewModel.showErrorText) {
                Button("Retry") {
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
            }
            .task {
                await viewModel.fetchRecipes()
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    ContentView()
}
