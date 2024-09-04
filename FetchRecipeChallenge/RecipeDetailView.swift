//
//  RecipeDetailView.swift
//  FetchRecipeChallenge
//
//  Created by Gershon Lev on 9/3/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var viewModel: RecipeDetailViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: viewModel.recipe.imageUrl)!) { img in
                        img.resizable()
                            .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipShape(.rect(cornerRadius: 5))
                    } placeholder: {
                        ProgressView()
                        .frame(width: 70, height: 70)
                    }
                    .padding(.bottom)
                    HStack() {
                        Spacer()
                        Text(viewModel.recipe.name)
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    Text("Instructions")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.cyan)
                        .padding([.leading, .bottom])
                        .opacity(viewModel.recipe.instructions == nil ? 0 : 1.0)
                    
                    Text(viewModel.recipe.instructions ?? "")
                        .font(.caption)
                        .padding([.leading, .trailing, .bottom])
                    
                    Text("Ingredients")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.cyan)
                        .padding([.leading, .bottom])
                    
                    ForEach(viewModel.recipe.measuredIngredients) { val in
                        HStack() {
                            Text(val.ingredient.capitalized)
                                .font(.caption)
                                .bold()
                            Text(val.measurement)
                                .font(.caption)
                        }.padding([.leading, .bottom, .trailing])
                    }
                }
            }
        }
        .task {
            await viewModel.fetchFullRecipe()
        }
    }
}

#Preview {
    let recipe = Recipe(id: "333", name: "Cake", imageUrl: "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg")
    return RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: recipe))
}
