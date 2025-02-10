//
//  LogStateOfMindView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogStateOfMindView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var logStateOfMindModel: LogStateOfMindViewModel
    var bigPrevDate: Date? = nil
    var isPrevLog: Bool = false
    
    var body: some View {
        ZStackWithGradient {
            ScrollView(showsIndicators: false) {
                HStack {
                    Spacer()
                    Image(.help)
                        .resizable()
                        .scaledToFill()
                        .clipShape(.rect(cornerRadius: 12.0))
                        .rotationEffect(Angle(degrees: -15))
                        .frame(width: 100, height: 100)
                        .offset(x: 20)
                    Image(.happy)
                        .resizable()
                        .scaledToFill()
                        .clipShape(.rect(cornerRadius: 12.0))
                        .rotationEffect(Angle(degrees: 15))
                        .frame(width: 100, height: 100)
                        .offset(x: -20)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 50)
                .shadow(radius: 10)
                
                VStack {
                    Text("Log an Emotion or Mood")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    if let bigDate = bigPrevDate {
                        Text(bigDate.customDate)
                            .font(.title.bold())
                            .padding(.bottom)
                            .padding(.top, 0.5)
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        NavigationLink(destination: LogEmotion(
                            logStateOfMindModel: $logStateOfMindModel,
                            prevDate: bigPrevDate ?? Date(),
                            isPrevLog: isPrevLog
                        )) {
                            ChoiceCard(
                                labelText: "Emotion",
                                labelIcon: "clock",
                                cardText: bigPrevDate == nil ? "How you feel at this very moment." : "How you felt in a previous moment."
                            )
                        }
                        
                        NavigationLink(destination: LogMood(
                            logStateOfMindModel: $logStateOfMindModel,
                            prevDate: bigPrevDate ?? Date(),
                            isPrevLog: isPrevLog
                        )) {
                            ChoiceCard(
                                labelText: "Mood",
                                labelIcon: "sunset.fill",
                                cardText: bigPrevDate == nil ? "How you've felt the whole day" : "How you felt overall that day.",
                                showDate: bigPrevDate != nil ? false : true
                            )
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(20)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Cancel") {
                    logStateOfMindModel.cancelStateOfMindFlow()
                    dismiss()
                }
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LogStateOfMindView(logStateOfMindModel: .constant(LogStateOfMindViewModel()))
    }
}

struct ChoiceCard: View {
    let labelText: String
    let labelIcon: String
    let cardText: String
    var showTime: Bool = false
    var showDate: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label(labelText, systemImage: labelIcon)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .font(.headline)
                .foregroundStyle(.secondary)
                
                Text(cardText)
                    .font(.title2.weight(.medium))
                
                Group {
                    if showTime {
                        Text(Date().formatted(date: .omitted, time: .shortened))
                            .foregroundColor(.accent)
                    }
                    
                    if showDate {
                        Text(Date().customDate)
                            .foregroundColor(.accent)
                    }
                }
                .font(.caption)
            }
            Spacer()
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 12.0))
    }
}

