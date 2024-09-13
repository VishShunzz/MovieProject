//
//  MovieView.swift
//  Movies_Project
//
//  Created by Vishal  on 07/09/24.
//

import SwiftUI

struct MovieView: View {
    @ObservedObject var viewModel = MovieViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                List(0..<viewModel.inputModel.count, id: \.self) { index in
                    let data = viewModel.inputModel[index]
                    if viewModel.searchText.isEmpty {
                        SectionTopView(title: data.type.rawValue, isExpanded: data.isCollapse)
                            .onTapGesture {
                                withAnimation {
                                    if data.type != .allMovies {
                                        viewModel.updateSection(index) // Toggle expand/collapse
                                    } else {
                                        viewModel.allMovies = true
                                    }
                                }
                            }
                            .id(data.id)
                    }
                    
                    if !data.isCollapse {
                        if data.type != .allMovies {
                            ForEach(0..<(data.val?.count ?? 0), id: \.self) { i in
                                if let val = data.val?[i] {
                                    MultipleSelectionRow(
                                        option: val,
                                        isSelected: data.selectedVal.contains(val)) {
                                            viewModel.filterInfo(type: data.type, selectedVal: val)
                                        }
                                        .id(UUID())
                                }
                            }
                        }
                    }
                    
                    if data.type == .allMovies {
                        ForEach(0..<viewModel.filteredMovies.count, id: \.self) { index in
                            let movieVal = viewModel.filteredMovies[index]
                            NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movieData: movieVal))) {
                                MovieListView(movieData: movieVal)
                                    .id(movieVal.id)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText,prompt: "Search movies by title/Actor/Genre/Director")
                
                navigation()
            }
            .navigationTitle("Movie Database")
        }
        .onAppear {
            viewModel.getInfo()
        }
    }
    
    @ViewBuilder func navigation() -> some View {
        VStack {
            NavigationLink(destination: AllMoviewView(allMovies: viewModel.modelData), isActive: $viewModel.allMovies) {
                EmptyView()
                
            }
        }
    }
}

#Preview {
    MovieView()
}
