//
//  ZStackWithGradient.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 7/2/2025.
//

import SwiftUI

struct ZStackWithGradient<Content: View>: View {
    var color: Color? = nil
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            CircularBackgroundColor(color: color)
            
            content()
        }
    }
}

#Preview {
    ZStackWithGradient(content: {})
}
