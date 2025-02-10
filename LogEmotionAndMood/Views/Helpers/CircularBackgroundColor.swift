//
//  CircularBackgroundColor.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 7/2/2025.
//

import SwiftUI

struct CircularBackgroundColor: View {
    var color: Color? = nil
    
    var body: some View {
        if let color {
            Circle()
                .fill(color)
                .frame(width: 300, height: 300)
                .blur(radius: 200)
                .offset(x: 100, y: 150)
        } else {
            Circle()
                .fill(Color(.accent))
                .frame(width: 300, height: 300)
                .blur(radius: 200)
                .offset(x: 100, y: 150)
        }
    }
}

#Preview {
    CircularBackgroundColor()
    //    CircularBackgroundColor(color: Color(.systemPink))
}
