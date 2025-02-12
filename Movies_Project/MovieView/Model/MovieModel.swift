//
//  MovieModel.swift
//  Movies_Project
//
//  Created by Vishal  on 07/09/24.
//

import Foundation


// MARK: - MovieModel
struct MovieModel: Decodable, Identifiable {
    let id = UUID()
    let title, year, rated, released: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]?
    let metascore, imdbRating, imdbVotes, imdbID: String?
    let type: String?
    var genreData: [String] {
        genre?.components(separatedBy: ",") ?? []
    }
    var directorData: [String] {
        director?.components(separatedBy: ",") ?? []
    }
    
    var actorsData: [String] {
        actors?.components(separatedBy: ",") ?? []
    }
    
    enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case rated = "Rated"
            case released = "Released"
            case runtime = "Runtime"
            case genre = "Genre"
            case director = "Director"
            case writer = "Writer"
            case actors = "Actors"
            case plot = "Plot"
            case language = "Language"
            case country = "Country"
            case awards = "Awards"
            case poster = "Poster"
            case ratings = "Ratings"
            case metascore = "Metascore"
            case imdbRating, imdbVotes, imdbID
            case type = "Type"
        }
}

// MARK: - Rating
struct Rating: Decodable, Hashable {
    let source, value: String?
    
    enum CodingKeys: String, CodingKey {
            case source = "Source"
            case value = "Value"
        }
}
