//
//  RatingSelectorView.swift
//  Movies_Project
//
//  Created by Vishal  on 08/09/24.
//

import Foundation
import SwiftUI

struct RatingSelector: View {
    @State var selectedSource: String = ""
    
    let rating: [Rating]
    
    var body: some View {
        VStack {
            Picker("Select Rating Source", selection: $selectedSource) {
                ForEach(rating, id: \.self) { data in
                    Text(data.source ?? "")
                        .tag(data.source ?? "")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)
            
//            Custom UI Control to Display Rating Value
            if !selectedSource.isEmpty {
                HStack {
                    Text("\(selectedSource) Rating:")
                        .font(.headline)
                    
                    if let index = rating.firstIndex(where: {$0.source == selectedSource}) {
                        Text(rating[index].value ?? "")
                            .font(.title)
                            .bold()
                            .foregroundColor(.blue)
                    } else {
                        Text("N/A")
                            .font(.title)
                            .bold()
                            .foregroundColor(.red)
                    }
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }
        }
    }
}
