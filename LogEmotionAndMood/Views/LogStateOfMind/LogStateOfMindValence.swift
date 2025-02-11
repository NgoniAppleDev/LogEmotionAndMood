//
//  LogStateOfMindValence.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 6/2/2025.
//

import HealthKit
import SwiftUI

struct LogStateOfMindValence: View {
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    var prevDate: Date? = nil
    var isPrevLog: Bool = false
    var navTitle: String = "Emotion"
    let today: Date = Date()
    
    var body: some View {
        let extractedValues = logStateOfMindModel.extractedValues
        
        ZStackWithGradient(color: extractedValues.faceColor) {
            VStack {
                ScrollView {
                    VStack(spacing: 50) {
                        TopTitle(
                            extractedValues: extractedValues,
                            isPrevLog: isPrevLog
                        )
                        IconView(faceColor: extractedValues.faceColor, selectedMood: extractedValues.selectedMood)
                        
                        Slider(
                            value: $logStateOfMindModel.moodValence.animation(),
                            in: -1...1, step: 0.25
                        )
                        .tint(extractedValues.faceColor)
                    }
                    .padding()
                }
                
                NavigationLink(destination: LogStateOfMindDescription(logStateOfMindModel: logStateOfMindModel, prevDate: prevDate)) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(extractedValues.selectedMood == Images.noneFace ? .black : .white)
                        .font(.headline)
                        .contentShape(RoundedRectangle(cornerRadius: 12.0))
                }
                .padding()
                .background(extractedValues.faceColor, in: .rect(cornerRadius: 12.0))
                .padding(.horizontal)
                .buttonStyle(.plain)
            }
        }
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Cancel") {
                logStateOfMindModel.cancelStateOfMindFlow()
            }
        }
    }
}

#Preview {
    NavigationStack {
        LogStateOfMindValence(logStateOfMindModel: LogStateOfMindViewModel())
    }
}

struct TopTitle: View {
    let extractedValues: (moodValence: Double, kind: HKStateOfMind.Kind, feeling: String, faceColor: Color, selectedMood: Image)
    var isPrevLog: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(isPrevLog == false ? "How Do You Feel" : "How You Felt")
                .font(.title.bold())
            VStack(alignment: .leading) {
                Text(isPrevLog == false ? "Now:" : extractedValues.kind == .momentaryEmotion ? "in the previous moment" : "that day?")
                    .font(.title.bold())
                Text(extractedValues.feeling)
                    .contentTransition(.numericText(value: extractedValues.moodValence))
                    .foregroundColor(extractedValues.faceColor)
                    .font(.largeTitle.bold())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

