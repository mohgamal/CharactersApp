//
//  CharacterDetailsView.swift
//  CharactersApp
//
//  Created by Mohammed Abdelaty on 22/10/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: URL(string: viewModel.character.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()  // Placeholder while loading
                }
                // Character name and status
                HStack {
                    Text(viewModel.character.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Status with background
                    Text(viewModel.character.status)
                        .font(.caption)
                        .padding(8)
                        .background(Capsule().fill(Color.blue.opacity(0.2)))
                        .foregroundColor(.blue)
                }
                
                // Character species and gender
                Text("\(viewModel.character.species) • \(viewModel.character.gender ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Character location
                HStack {
                    Text("Location :")
                        .fontWeight(.bold)
                    Text(viewModel.character.location?.name ?? "")
                }
                .font(.subheadline)
                .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
    }
}

