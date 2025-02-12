//
//  IconView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

enum IconSize {
    case medium
    case large
}

struct IconView: View {
    var faceColor: Color
    var selectedMood: Image
    var animateIcon: Bool = true
    var size: IconSize = .large
    
    @State private var scale = false
    @State private var moodOpacity: Double = 1
    @State private var currentMood: Image
    
    init(faceColor: Color, selectedMood: Image, animateIcon: Bool = true, size: IconSize = .large) {
        self.faceColor = faceColor
        self.selectedMood = selectedMood
        self.animateIcon = animateIcon
        self.size = size
        _currentMood = State(initialValue: selectedMood) // Initialize with selected mood
    }
    
    var body: some View {
        ZStack {
            Circle().frame(width: size == .large ? 220 : 110, height: size == .large ? 220 : 110)
                .foregroundStyle(faceColor)
                .opacity(scale ? 0 : 1)
                .scaleEffect(scale ? 1: 0.4)
            
            Circle().frame(width: size == .large ? 300 : 110, height: size == .large ? 300 : 110)
                .foregroundStyle(faceColor)
                .opacity(scale ? 0 : 1)
                .scaleEffect(scale ? 1: 0.2)
            
            // Mood icon
            currentMood
                .resizable()
                .scaledToFill()
                .frame(width: size == .large ? 150 : 110, height: size == .large ? 150 : 110)
                .opacity(moodOpacity)
                .transition(.opacity) // Smoothly fade in and out
        }
        .onChange(of: selectedMood, { _, newMood in
            withAnimation(.easeOut(duration: 0.2)) {
                moodOpacity = 0.85 // Fade out
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                currentMood = newMood // Change the image
                
                withAnimation(.easeIn(duration: 0.3)) {
                    moodOpacity = 1 // Fade back in
                }
            }
        })
        .onAppear {
            if animateIcon {
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                    scale.toggle()
                }
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    IconView(faceColor: Color(.label), selectedMood: Images.noneFace)
}
