//
//  MultipleSelectionRow.swift
//  Movies_Project
//
//  Created by Vishal  on 14/09/24.
//

import SwiftUI

struct MultipleSelectionRow: View {
    let option: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(option)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}
