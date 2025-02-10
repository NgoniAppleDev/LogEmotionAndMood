//
//  MoodModel.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 6/2/2025.
//

import SwiftUI

struct MoodModel: Identifiable {
    var id = UUID()
    var feeling: String
    var mood: Image
    var color: Color
    
    enum Mood: String {
        case veryUnpleasant = "Very Unpleasant"
        case unPleasant = "Unpleasant"
        case slightlyUnpleasant = "Slightly Unpleasant"
        case neutral = "Neutral"
        case slightlyPleasant = "Slightly Pleasant"
        case pleasant = "Pleasant"
        case veryPleasant = "Very Pleasant"
        
        func getColor() -> Color {
            switch self {
            case .veryUnpleasant:
                    .indigo
            case .unPleasant:
                    .indigo
            case .slightlyUnpleasant:
                    .blue
            case .neutral:
                    .cyan
            case .slightlyPleasant:
                    .teal
            case .pleasant:
                    .yellow
            case .veryPleasant:
                    .orange
            }
        }
        
        func getSelectedMood() -> Image {
            switch self {
            case .veryUnpleasant:
                Images.unhappyFace
            case .unPleasant:
                Images.unhappyFace
            case .slightlyUnpleasant:
                Images.sadFace
            case .neutral:
                Images.normalFace
            case .slightlyPleasant:
                Images.goodFace
            case .pleasant:
                Images.goodFace
            case .veryPleasant:
                Images.happyFace
            }
        }
    }
    
    static let moodMappings: [Double: (feeling: String, faceColor: Color, selectedMood: Image)] = [
        -1: (
            Mood.veryUnpleasant.rawValue,
            Mood.veryUnpleasant.getColor(),
            Mood.veryUnpleasant.getSelectedMood()
        ),
         -0.75: (
            Mood.veryUnpleasant.rawValue,
            Mood.veryUnpleasant.getColor(),
            Mood.veryUnpleasant.getSelectedMood()
         ),
         -0.5: (
            Mood.unPleasant.rawValue,
            Mood.unPleasant.getColor(),
            Mood.unPleasant.getSelectedMood()
         ),
         -0.25: (
            Mood.slightlyUnpleasant.rawValue,
            Mood.slightlyUnpleasant.getColor(),
            Mood.slightlyUnpleasant.getSelectedMood()
         ),
         0: (
            Mood.neutral.rawValue,
            Mood.neutral.getColor(),
            Mood.neutral.getSelectedMood()
         ),
         0.25: (
            Mood.slightlyPleasant.rawValue,
            Mood.slightlyPleasant.getColor(),
            Mood.slightlyPleasant.getSelectedMood()
         ),
         0.5: (
            Mood.pleasant.rawValue,
            Mood.pleasant.getColor(),
            Mood.pleasant.getSelectedMood()
         ),
         0.75: (
            Mood.veryPleasant.rawValue,
            Mood.veryPleasant.getColor(),
            Mood.veryPleasant.getSelectedMood()
         ),
         1: (
            Mood.veryPleasant.rawValue,
            Mood.veryPleasant.getColor(),
            Mood.veryPleasant.getSelectedMood()
         )
    ]
    
    static func interpolatedColor(for value: Double) -> Color {
        let moodColors: [Color] = [
            Mood.veryUnpleasant.getColor(),  // Very Unpleasant
            Mood.veryUnpleasant.getColor(),  // Very Unpleasant
            Mood.unPleasant.getColor(),     // Unpleasant
            Mood.slightlyUnpleasant.getColor(),  // Slightly Unpleasant
            Mood.neutral.getColor(),  // Neutral
            Mood.slightlyPleasant.getColor(),   // Slightly Pleasant
            Mood.pleasant.getColor(),    // Pleasant
            Mood.veryPleasant.getColor(),   // Very Pleasant
            Mood.veryPleasant.getColor()   // Very Pleasant
        ]
        
        let minValue: Double = -1
        let maxValue: Double = 1
        
        let normalizedValue = (value - minValue) / (maxValue - minValue) // Convert range to 0...1
        let steps = Double(moodColors.count - 1)
        let position = normalizedValue * steps
        let lowerIndex = Int(position)
        let upperIndex = min(lowerIndex + 1, moodColors.count - 1)
        let fraction = position - Double(lowerIndex)
        
        return blend(moodColors[lowerIndex], moodColors[upperIndex], fraction: fraction)
    }
    
    static func blend(_ color1: Color, _ color2: Color, fraction: Double) -> Color {
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
