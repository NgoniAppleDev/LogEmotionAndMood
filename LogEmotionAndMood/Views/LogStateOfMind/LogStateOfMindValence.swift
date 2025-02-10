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
    
    var TopTitle: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How Do You Feel")
            HStack {
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
        ZStackWithGradient(color: logStateOfMindModel.faceColor) {
            VStack {
                ScrollView {
                    VStack(spacing: 50) {
                        TopTitle
                        IconView(faceColor: logStateOfMindModel.faceColor, selectedMood: logStateOfMindModel.selectedMood)
                        
                        Slider(value: $logStateOfMindModel.moodValence.animation(), in: -1...1, step: 0.5)
                            .tint(logStateOfMindModel.faceColor)
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
                .background(logStateOfMindModel.faceColor, in: .rect(cornerRadius: 12.0))
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
