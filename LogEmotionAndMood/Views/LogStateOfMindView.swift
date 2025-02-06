//
//  LogStateOfMindView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogStateOfMindView: View {
    @Binding var logStateOfMindModel: LogStateOfMindViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Spacer()
                Image(.help)
                    .resizable()
                    .scaledToFill()
                    .clipShape(.rect(cornerRadius: 12.0))
                    .rotationEffect(Angle(degrees: -15))
                    .frame(width: 150, height: 150)
                    .offset(x: 20)
                Image(.happy)
                    .resizable()
                    .scaledToFill()
                    .clipShape(.rect(cornerRadius: 12.0))
                    .rotationEffect(Angle(degrees: 15))
                    .frame(width: 150, height: 150)
                    .offset(x: -20)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 50)
            .shadow(radius: 10)
            
            Text("Log an Emotion or Mood")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    NavigationLink(destination: LogEmotion(logStateOfMindModel: $logStateOfMindModel)) {
                        ChoiceCard(
                            labelText: "Emotion",
                            labelIcon: "clock",
                            cardText: "How you feel at this very moment."
                        )
                    }
                    
                    NavigationLink(destination: LogMood(logStateOfMindModel: $logStateOfMindModel)) {
                        ChoiceCard(
                            labelText: "Mood",
                            labelIcon: "sunset.fill",
                            cardText: "How you've felt the whole day",
                            showDate: true
                        )
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .background(LinearGradient(
            colors: [Color(.systemBackground), Color(.systemBackground), Color(.systemBlue), Color(.systemPink)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Cancel") { logStateOfMindModel.cancelStateOfMindFlow() }
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
                Text(cardText)
                    .font(.title2.weight(.medium))
                
                Group {
                    if showTime {
                        Text(Date().formatted(date: .omitted, time: .shortened))
                    }
                    
                    if showDate {
                        Text(customDate())
                    }
                }
                .font(.caption)
            }
            Spacer()
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 12.0))
    }
    
    func customDate() -> String {
        Date().formatted(.dateTime.weekday()) + ", " + Date().formatted(.dateTime.day(.twoDigits)) + " " + Date().formatted(.dateTime.month())
    }
}
