//
//  AllMoviewView.swift
//  Movies_Project
//
//  Created by Vishal  on 12/09/24.
//

import Foundation
import SwiftUI

struct AllMoviewView: View {
    var allMovies: [MovieModel]
    var body: some View {
        List {
            ForEach(0..<(allMovies.count), id: \.self) { i in
                    let val = allMovies[i]
                    NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movieData: val))) {
                        MovieListView(movieData: val)
                    }
            }
        }
        .listStyle(.plain)
    }
}
