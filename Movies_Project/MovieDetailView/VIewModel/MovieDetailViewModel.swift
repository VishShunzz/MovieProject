//
//  MovieDetailViewModel.swift
//  Movies_Project
//
//  Created by Vishal  on 08/09/24.
//

import Foundation


class MovieDetailViewModel: ObservableObject {
    var movieData: MovieModel
    var selectedRatingSource: String = ""
    
    init(movieData: MovieModel) {
        self.movieData = movieData
    }
}
