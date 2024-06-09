//
//  LandingView.swift
//  recipes
//
//  Created by Elliott Griffin on 6/9/24.
//

import Foundation
import SwiftUI

struct LandingView: View {
    @State private var randomDessertImageURL: URL?
    var body: some View {
        VStack {
            Spacer()
            Text("Dessert Recipes")
                .font(.system(size: 40, weight: .light, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.darkGreen)
                .padding()
            Text("Discover our delicious treats!")
                .font(.system(size: 26, weight: .thin, design: .rounded))
                .padding(.horizontal)
            if let imageURL = randomDessertImageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 300, maxHeight: 400)
                        .cornerRadius(10)
                        .clipped()
                        .padding()
                } placeholder: {
                    ProgressView()
                        .frame(width: 150, height: 150)
                        .padding()
                }
            } else {
                ProgressView()
                    .frame(width: 150, height: 150)
                    .padding()
            }
            NavigationLink(destination: RecipesListView()) {
                Text("Enter")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.lightGreen)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .onAppear(perform: fetchRandomDessertImage)
    }
    private func fetchRandomDessertImage() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            if let dessertResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                if let randomDessert = dessertResponse.meals.randomElement(),
                   let imageUrl = URL(string: randomDessert.strMealThumb) {
                    DispatchQueue.main.async {
                        self.randomDessertImageURL = imageUrl
                    }
                }
            }
        }
    }.resume()
}
}
