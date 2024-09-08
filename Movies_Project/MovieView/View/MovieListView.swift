//
//  MovieListView.swift
//  Movies_Project
//
//  Created by Vishal  on 08/09/24.
//

import SwiftUI

struct MovieListView: View {
    let movieData: MovieModel
    var body: some View {
        HStack {
            CMPRemoteImage(url: movieData.poster ?? "")
                .frame(width: 80)
            VStack(alignment: .leading) {
                Text(movieData.title ?? "")
                    .font(.title2)
                HStack {
                    Text("Language: ")
                    Text(movieData.language ?? "")
                }
                .padding(.vertical, 4)
                HStack {
                    Text("Year: ")
                    Text(movieData.year ?? "")
                }
            }
            Spacer()
        }
    }
}
