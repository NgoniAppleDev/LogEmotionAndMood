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
    
    static let moodMappings: [Double: (feeling: String, faceColor: Color, selectedMood: Image)] = [
        -1: ("Very UnPleasant", .red, Images.unhappyFace),
         -0.5: ("UnPleasant", .blue, Images.sadFace),
         0: ("Neutral", .indigo, Images.normalFace),
         0.5: ("Pleasant", .yellow, Images.goodFace),
         1: ("Very Pleasant", .orange, Images.happyFace)
    ]
}
