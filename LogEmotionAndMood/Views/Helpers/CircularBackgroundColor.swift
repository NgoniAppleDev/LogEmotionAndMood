//
//  CircularBackgroundColor.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 7/2/2025.
//

import SwiftUI

struct CircularBackgroundColor: View {
    var color: Color? = nil
    let size: CGFloat = 300
    let blurRadius: CGFloat = 200
    let x: CGFloat = 100
    let y: CGFloat = 150
    
    var body: some View {
        if let color {
            Circle()
                .fill(color)
                .frame(width: size, height: size)
                .blur(radius: blurRadius)
                .offset(x: x, y: y)
        } else {
            Circle()
                .fill(Color(.accent))
                .frame(width: size, height: size)
                .blur(radius: blurRadius)
                .offset(x: x, y: y)
        }
    }
}

#Preview {
    CircularBackgroundColor()
    //    CircularBackgroundColor(color: Color(.systemPink))
}
