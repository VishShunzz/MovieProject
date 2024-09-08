//
//  SectionTopView.swift
//  Movies_Project
//
//  Created by Vishal  on 08/09/24.
//

import SwiftUI

struct SectionTopView: View {
    let title: String
    var isExpanded: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Image(systemName: isExpanded ? "chevron.right" : "chevron.down")
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle()) // Makes the whole header tappable
    }
}

