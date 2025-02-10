//
//  TestColorBlend.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 10/2/2025.
//

import SwiftUI

struct TestColorBlend: View {
    @State private var sliderValue: Double = 0.0
    let minValue: Double = -1
    let maxValue: Double = 1

    let moodColors: [Color] = [
        .purple,  // Very Unpleasant (-3)
        .red,     // Unpleasant (-2)
        .orange,  // Slightly Unpleasant (-1)
        .yellow,  // Neutral (0)
        .green,   // Slightly Pleasant (1)
        .blue,    // Pleasant (2)
        .indigo   // Very Pleasant (3)
    ]
    
    var body: some View {
        VStack {
            Text("Mood: \(sliderValue, specifier: "%.2f")")
                .font(.title)
                .foregroundColor(interpolatedColor(for: sliderValue))
                .padding()
            
            Slider(value: $sliderValue, in: minValue...maxValue)
                .padding()
                .accentColor(interpolatedColor(for: sliderValue))
        }
    }
    
    func interpolatedColor(for value: Double) -> Color {
        let normalizedValue = (value - minValue) / (maxValue - minValue) // Convert range to 0...1
        let steps = Double(moodColors.count - 1)
        let position = normalizedValue * steps
        let lowerIndex = Int(position)
        let upperIndex = min(lowerIndex + 1, moodColors.count - 1)
        let fraction = position - Double(lowerIndex)
        
        return blend(moodColors[lowerIndex], moodColors[upperIndex], fraction: fraction)
    }
    
    func blend(_ color1: Color, _ color2: Color, fraction: Double) -> Color {
        let uiColor1 = UIColor(color1)
        let uiColor2 = UIColor(color2)
        
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r = r1 + (r2 - r1) * CGFloat(fraction)
        let g = g1 + (g2 - g1) * CGFloat(fraction)
        let b = b1 + (b2 - b1) * CGFloat(fraction)
        let a = a1 + (a2 - a1) * CGFloat(fraction)
        
        return Color(UIColor(red: r, green: g, blue: b, alpha: a))
    }
}

#Preview {
    TestColorBlend()
}
