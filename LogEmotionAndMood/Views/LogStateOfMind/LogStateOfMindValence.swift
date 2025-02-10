//
//  LogStateOfMindValence.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 6/2/2025.
//

import HealthKit
import SwiftUI

struct LogStateOfMindValence: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    var prevDate: Date = Date()
    var isPrevLog: Bool = false
    var navTitle: String = "Emotion"
    var kind: HKStateOfMind.Kind = .momentaryEmotion
    let today: Date = Date()
    
    var body: some View {
        print("prev date: \(prevDate), today: \(today), \(today.normalizedDate <= prevDate.normalizedDate)")
        
        return ZStackWithGradient(color: logStateOfMindModel.faceColor) {
            VStack {
                ScrollView {
                    VStack(spacing: 50) {
                        TopTitle()
                        IconView(faceColor: logStateOfMindModel.faceColor, selectedMood: logStateOfMindModel.selectedMood)
                        
                        Slider(value: $logStateOfMindModel.moodValence.animation(), in: -1...1, step: 0.25)
                        .tint(logStateOfMindModel.faceColor)
                        .accentColor(logStateOfMindModel.faceColor)
                    }
                    .padding()
                }
                
                NavigationLink(destination: LogStateOfMindDescription(logStateOfMindModel: logStateOfMindModel, prevDate: prevDate)
                ) {
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
            Button("Cancel") {
                logStateOfMindModel.cancelStateOfMindFlow()
                dismiss()
            }
        }
    }
    
    @ViewBuilder
    func TopTitle() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(isPrevLog ? "How You Felt" : "How Do You Feel")
                .font(.title.bold())
            VStack(alignment: .leading) {
                Text(isPrevLog == false ? "Now:" : kind == .momentaryEmotion ? "in the previous moment" : "that day?")
                    .font(.title.bold())
                Text(logStateOfMindModel.feeling)
                    .contentTransition(.numericText(value: logStateOfMindModel.moodValence))
                    .foregroundColor(logStateOfMindModel.faceColor)
                    .font(.largeTitle.bold())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        LogStateOfMindValence(logStateOfMindModel:
            LogStateOfMindViewModel()
        )
    }
}
