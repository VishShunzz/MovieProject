//
//  MovieViewModel.swift
//  Movies_Project
//
//  Created by Vishal  on 07/09/24.
//

import Foundation

class MovieViewModel: ObservableObject {
    var modelData: [MovieModel] = []
    @Published var allMovies = false
    @Published var showMovies = false
    @Published var searchText: String = ""
    @Published var inputModel: [MovieInputModel] = []
    var filteredMovies: [MovieModel] {
        filterData()
    }
    
    /// To fetch the json information
    private func fetchData() {
        modelData = JsonDataLoaderFile.shared.loadJSONFromFile("movies", type: [MovieModel].self) ?? []
    }
    
    /// To update the information with the View
    func getInfo() {
        fetchData()
        updateInputModel()
    }
    
    /// Update the input model for view
    private func updateInputModel() {
        let smallestYear = Int(modelData.map({$0.year ?? ""}).min() ?? "0")
        let currentYear = Calendar.current.component(.year, from: Date())
        let yearData = Array(smallestYear!...currentYear)
        let yearStr = yearData.map { String($0) }
        let genreData = removeDuplicateVal(modelData.flatMap({$0.genreData}))
        let directorData = removeDuplicateVal(modelData.flatMap({$0.directorData}))
        let actorsData = removeDuplicateVal(modelData.flatMap({$0.actorsData}))
        
        inputModel.append(MovieInputModel(type: .year, val: yearStr))
        inputModel.append(MovieInputModel(type: .genre, val: genreData))
        inputModel.append(MovieInputModel(type: .directors, val: directorData))
        inputModel.append(MovieInputModel(type: .actors, val: actorsData))
        inputModel.append(MovieInputModel(type: .allMovies))
    }
    /// Expandable and collapse manage here
    /// - Parameter index: Section index value
    func updateSection(_ index: Int) {
        for i in 0..<inputModel.count {
            if i == index {
                inputModel[i].isCollapse.toggle()
            } else if i < inputModel.count - 1 {
                inputModel[i].isCollapse = true
            }
        }
    }
    
    /// Remove duplicated data while filtering info
    /// - Parameter arr: Array with dummy data
    /// - Returns: Sorted array with no duplicate values
    private func removeDuplicateVal(_ arr : [String?]) -> [String] {
        var data = Set<String>()
        let _ = arr.map { item in
            if let item {
                data.insert(item)
            }
        }
        return Array(data).sorted()
    }
    
    /// To update the filter information of checkmark
    /// - Parameters:
    ///   - type: Selected filter type (year, genre, director, actors)
    ///   - selectedVal: Selected value from the filter type
    func filterInfo( type: ListType, selectedVal: String) {
        if let index = inputModel.firstIndex(where: {$0.type == type}) {
            if inputModel[index].selectedVal.contains(selectedVal) {
                inputModel[index].selectedVal.remove(selectedVal)
            } else {
                inputModel[index].selectedVal.insert(selectedVal)
            }
            inputModel[index].isCollapse = false
            showMovies = true
        }
        if let index = inputModel.firstIndex(where: {$0.type == type}) {
            updateSection(index)
        }
    }
    
    /// Filter movies list based on search text
    /// - Returns: List of the filtered movies
    private func filterByQueries() -> [MovieModel] {
        return modelData.filter { movie in
            (movie.title?.lowercased() ?? "").contains(searchText.lowercased()) ||
            (movie.year?.lowercased() ?? "").contains(searchText.lowercased()) ||
            (movie.genre?.lowercased() ?? "").contains(searchText.lowercased()) ||
            (movie.director?.lowercased() ?? "").contains(searchText.lowercased()) ||
            (movie.actors?.lowercased() ?? "").contains(searchText.lowercased())
        }
    }
    
    /// Fetch filter data by checking all criteria (search text, year, genre, director, actors)
    /// - Returns: List of the movies
    private func filterData() -> [MovieModel] {
        if searchText.isEmpty {
            return modelData.filter { movie in
                // Apply filters by checking all criteria (year, genre, director, actors)
                let matchesYear = inputModel.first(where: { $0.type == .year })?.selectedVal.contains {
                    selectedYear in movie.year?.lowercased() == selectedYear.lowercased()
                } ?? true
                
                let matchesGenre = inputModel.first(where: { $0.type == .genre })?.selectedVal.contains {
                    selectedGenre in movie.genreData.contains{$0.lowercased() == selectedGenre.lowercased()}
                } ?? true
                
                let matchesDirector = inputModel.first(where: { $0.type == .directors })?.selectedVal.contains {
                    selectedDirector in movie.directorData.contains{$0.lowercased() == selectedDirector.lowercased()}
                } ?? true
                
                let matchesActors = inputModel.first(where: { $0.type == .actors })?.selectedVal.contains {
                    selectedActor in movie.actorsData.contains{$0.lowercased() == selectedActor.lowercased()}
                } ?? true
                
                return matchesYear || matchesGenre || matchesDirector || matchesActors
            }
        } else {
            return filterByQueries()
        }
    }
}
