//
//  MoodModel.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 6/2/2025.
//

import SwiftUI

struct MoodModel: Identifiable {
    var id = UUID()
    
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
                    .purple
            case .slightlyUnpleasant:
                    .blue
            case .neutral:
                    .cyan
            case .slightlyPleasant:
                    .green
            case .pleasant:
                    .yellow
            case .veryPleasant:
                    .orange
            }
        }
        
        func getSelectedMood() -> Image {
            switch self {
            case .veryUnpleasant:
                Images.veryUnpleasantFace
            case .unPleasant:
                Images.unpleasantFace
            case .slightlyUnpleasant:
                Images.slightlyUnpleasantFace
            case .neutral:
                Images.neutralFace
            case .slightlyPleasant:
                Images.slightlyPleasantFace
            case .pleasant:
                Images.pleasantFace
            case .veryPleasant:
                Images.veryPleasantFace
            }
        }
    }
    
    static let moodMappings: [Double: (feeling: String, faceColor: Color, selectedMood: Image)] = [
        -1: (
            Mood.veryUnpleasant.rawValue,
            Mood.veryUnpleasant.getColor(),
            Images.veryUnpleasantFace2
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
            Images.veryPleasantFace2
         )
    ]
    
    
    static func interpolatedMoodMapping(for value: Double) -> (feeling: String, faceColor: Color, selectedMood: Image) {
        let sortedKeys = moodMappings.keys.sorted()
        
        // Find two closest keys
        guard let lower = sortedKeys.last(where: { $0 <= value }),
              let upper = sortedKeys.first(where: { $0 >= value }),
              let lowerMood = moodMappings[lower],
              let upperMood = moodMappings[upper] else {
            return moodMappings[0]!  // Default to neutral if something goes wrong
        }
        
        // If exact match, return directly
        if lower == upper { return lowerMood }
        
        // Calculate interpolation factor (0 to 1)
        let factor = (value - lower) / (upper - lower)
        
        // Interpolate color
        let interpolatedColor = Color(
            red: lowerMood.faceColor.components.red + factor * (upperMood.faceColor.components.red - lowerMood.faceColor.components.red),
            green: lowerMood.faceColor.components.green + factor * (upperMood.faceColor.components.green - lowerMood.faceColor.components.green),
            blue: lowerMood.faceColor.components.blue + factor * (upperMood.faceColor.components.blue - lowerMood.faceColor.components.blue)
        )
        
        // Interpolate text
        let interpolatedFeeling = interpolateMoodText(lowerMood.feeling, upperMood.feeling, factor)
        
        // Interpolate image (Choose closer one)
        let interpolatedImage = factor < 0.5 ? lowerMood.selectedMood : upperMood.selectedMood
        
        return (interpolatedFeeling, interpolatedColor, interpolatedImage)
    }
    
    static func interpolateMoodText(_ lower: String, _ upper: String, _ factor: Double) -> String {
        return factor < 0.5 ? lower : upper  // Pick the dominant mood
    }
    
}

// Color extension to get RGB components
extension Color {
    var components: (red: Double, green: Double, blue: Double) {
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #else
        typealias NativeColor = NSColor
        #endif
        guard let components = NativeColor(self).cgColor.components else { return (0, 0, 0) }
        return (Double(components[0]), Double(components[1]), Double(components[2]))
    }
}
