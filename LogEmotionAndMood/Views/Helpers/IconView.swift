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
    @State private var scale = false
    var selectedMood: Image
    @State private var faceScale: CGFloat = 1
    var animateIcon: Bool = true
    var size: IconSize = .large
    
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
            
            selectedMood
                .resizable().scaledToFill()
                .frame(width: size == .large ? 150 : 110, height: size == .large ? 150 : 110)
                .scaleEffect(faceScale)
        }
        .onChange(of: selectedMood, { _, _ in
            withAnimation {
                faceScale = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    faceScale = 1
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
