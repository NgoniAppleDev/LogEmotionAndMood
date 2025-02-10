//
//  LogStateOfMindValence.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 6/2/2025.
//

import HealthKit
import SwiftUI

struct LogStateOfMindValence: View {
    @Binding var logStateOfMindModel: LogStateOfMindViewModel
    var prevDate: Date = Date()
    var navTitle: String = "Emotion"
    var kind: HKStateOfMind.Kind = .momentaryEmotion
    @State private var sliderValue: Double = 0.0
    
    var TopTitle: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How Do You Feel")
            VStack(alignment: .leading) {
                Text("Now:")
                Text(logStateOfMindModel.feeling)
                    .foregroundColor(logStateOfMindModel.faceColor)
                    .contentTransition(.numericText())
            }
        }
        .font(.largeTitle.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var body: some View {
        ZStackWithGradient(color: MoodModel.interpolatedColor(for: logStateOfMindModel.moodValence)) {
            VStack {
                ScrollView {
                    VStack(spacing: 50) {
                        TopTitle
                        IconView(faceColor: MoodModel.interpolatedColor(for: logStateOfMindModel.moodValence), selectedMood: logStateOfMindModel.selectedMood)
                        
                        Slider(value: $logStateOfMindModel.moodValence, in: -1...1
                               //                               , step: 0.25
                        )
                        .tint(MoodModel.interpolatedColor(for: logStateOfMindModel.moodValence))
                        .accentColor(MoodModel.interpolatedColor(for: logStateOfMindModel.moodValence))
                    }
                    .padding()
                }
                
                NavigationLink(destination: LogStateOfMindDescription(logStateOfMindModel: $logStateOfMindModel, prevDate: prevDate)) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(logStateOfMindModel.selectedMood == Images.noneFace ? .black : .white)
                        .font(.headline)
                        .contentShape(RoundedRectangle(cornerRadius: 12.0))
                }
                .padding()
                .background(MoodModel.interpolatedColor(for: logStateOfMindModel.moodValence), in: .rect(cornerRadius: 12.0))
                .padding(.horizontal)
                .buttonStyle(.plain)
            }
        }
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Cancel") { logStateOfMindModel.cancelStateOfMindFlow() }
        }
    }
}

#Preview {
    NavigationStack {
        LogStateOfMindValence(logStateOfMindModel: .constant(LogStateOfMindViewModel()))
    }
}
