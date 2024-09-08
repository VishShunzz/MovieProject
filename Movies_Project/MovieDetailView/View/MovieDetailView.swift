//
//  MovieDetailView.swift
//  Movies_Project
//
//  Created by Vishal  on 08/09/24.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Movie Poster
                CMPRemoteImage(url: viewModel.movieData.poster ?? "")
                
                // Movie Title and Genre
                Text(viewModel.movieData.title ?? "")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                Text(viewModel.movieData.genre ?? "")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                // Plot
                Text("Plot")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Text(viewModel.movieData.plot ?? "")
                    .padding(.bottom)
                
                // Cast & Crew
                Text("Cast & Crew")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Text("Director: \(viewModel.movieData.director ?? "")")
                Text("Actor: \(viewModel.movieData.actors ?? "")")
                    .padding(.bottom)
                
                // Release Date
                Text("Released: \(viewModel.movieData.released ?? "")")
                    .font(.subheadline)
                    .padding(.bottom)
                
                // Rating Section
                Text("Rating")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                // Custom Rating Selector
                RatingSelector(rating: viewModel.movieData.ratings ?? [])
                
//                // Custom UI Control to Display Rating Value
//                if !viewModel.selectedRatingSource.isEmpty {
//                    RatingValueView(selectedSource: $viewModel.selectedRatingSource, rating: viewModel.movieData.ratings ?? [])
//                }
            }
            .padding()
        }
        .navigationTitle(viewModel.movieData.title ?? "")
    }
}

//#Preview {
//    MovieDetailView()
//}





