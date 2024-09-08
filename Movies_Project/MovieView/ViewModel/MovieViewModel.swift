//
//  MovieViewModel.swift
//  Movies_Project
//
//  Created by Vishal  on 07/09/24.
//

import Foundation

class MovieViewModel: ObservableObject {
    private var modelData: [MovieModel] = []
    @Published var searchText: String = "" {
        didSet {
            filterMovies()
        }
    }
    @Published var inputModel: [MovieInputModel] = []
    
    private func fetchData() {
        modelData = JsonDataLoaderFile.shared.loadJSONFromFile("movies", type: [MovieModel].self) ?? []
    }
    
    func getInfo() {
        fetchData()
        let yearData = ["2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","20013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024"]
        let genreData = ["Documentry", "Adventure", "Crime", "Thriller", "Drama", "Western", "Comedy", "Fantasy", "Sci-Fi", "Biography", "History", "Action", "Fantasy", "Family", "Sport", "Romance", "Animation"]
        let directorData = removeDuplicateVal(modelData.map({$0.director}))
        let actorsData = removeDuplicateVal(modelData.map({$0.actors}))
        
        inputModel.append(MovieInputModel(type: .year, val: yearData))
        inputModel.append(MovieInputModel(type: .genre, val: genreData))
        inputModel.append(MovieInputModel(type: .directors, val: directorData))
        inputModel.append(MovieInputModel(type: .actors, val: actorsData))
        inputModel.append(MovieInputModel(isCollapse: false, type: .allMovies, allMovies: modelData))
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
    
    func filterWithType( type: ListType, selectedVal: String) {
        if let index = inputModel.firstIndex(where: {$0.type == .allMovies}) {
            switch type {
            case .year:
                inputModel[index].allMovies = modelData.filter { movie in
                    (movie.year?.lowercased() ?? "").contains(selectedVal.lowercased())
                }
            case .genre:
                inputModel[index].allMovies = modelData.filter { movie in
                    (movie.genre?.lowercased() ?? "").contains(selectedVal.lowercased())
                }
            case .directors:
                inputModel[index].allMovies = modelData.filter { movie in
                    (movie.director?.lowercased() ?? "").contains(selectedVal.lowercased())
                }
            case .actors:
                inputModel[index].allMovies = modelData.filter { movie in
                    (movie.actors?.lowercased() ?? "").contains(selectedVal.lowercased())
                }
            case .allMovies:
                break
            }
            inputModel[index].isCollapse = false
        }
        
        if let index = inputModel.firstIndex(where: {$0.type == type}) {
            updateSection(index)
        }
        
    }
    
    
    // Function to filter movies based on search text
        private func filterMovies() {
            if let index = inputModel.firstIndex(where: {$0.type == .allMovies}) {
                if searchText.isEmpty {
                    inputModel[index].allMovies = modelData
                } else {
                    inputModel[index].allMovies = modelData.filter { movie in
                        (movie.title?.lowercased() ?? "").contains(searchText.lowercased()) ||
                        (movie.genre?.lowercased() ?? "").contains(searchText.lowercased()) ||
                        (movie.director?.lowercased() ?? "").contains(searchText.lowercased()) ||
                        (movie.actors?.lowercased() ?? "").contains(searchText.lowercased())
                    }
                }
            }
        }
}


extension MovieViewModel {
    
}
