//
//  MoodLabelItem.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct MoodLabelItem<T: Hashable>: View {
    @Binding var selectedItems: Set<T>
    var item: T
    var text: String
    var faceColor: Color
    
    var body: some View {
        Button {
            if selectedItems.contains(item) {
                selectedItems.remove(item)
            } else {
                selectedItems.insert(item)
            }
        } label: {
            Text(text)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .background(selectedItems.contains(item) ? faceColor : .clear)
                .clipShape(Capsule())
                .foregroundColor(Color(.label))
        }
    }
}
