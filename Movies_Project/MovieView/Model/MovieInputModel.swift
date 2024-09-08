//
//  MovieInputModel.swift
//  Movies_Project
//
//  Created by Vishal  on 08/09/24.
//

import Foundation

struct MovieInputModel: Identifiable {
    let id = UUID()
    var isCollapse = true
    var type: ListType
    var val: [String?]?
    var allMovies: [MovieModel]?
}

enum ListType: String {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
    case allMovies = "All Movies"
}
