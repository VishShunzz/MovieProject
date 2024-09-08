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
                                    viewModel.updateSection(index) // Toggle expand/collapse
                                }
                            }
                    }
                    
                    if !data.isCollapse {
                        if data.type != .allMovies {
                            ForEach(0..<(data.val?.count ?? 0), id: \.self) { i in
                                if let val = data.val?[i] {
                                    Text(val)
                                        .onTapGesture {
                                            withAnimation {
                                                viewModel.filterWithType(type: data.type, selectedVal: val)
                                            }
                                        }
                                }
                            }
                        } else {
                            ForEach(0..<(data.allMovies?.count ?? 0), id: \.self) { i in
                                if (i < data.allMovies?.count ?? 0), let val = data.allMovies?[i] {
                                    NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(movieData: val))) {
                                        MovieListView(movieData: val)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText,prompt: "Search movies by title/Actor/Genre/Director")
            }
            .navigationTitle("Movie Database")
        }
        .onAppear {
            viewModel.getInfo()
        }        
    }
}

#Preview {
    MovieView()
}
