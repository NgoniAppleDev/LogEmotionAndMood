//
//  LogStateOfMindView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogStateOfMindView: View {
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    var bigPrevDate: Date? = nil
    var isPrevLog: Bool = false
    
    var body: some View {
        ZStackWithGradient {
            ScrollView(showsIndicators: false) {
                TopImages()
                
                VStack {
                    Text("Log an Emotion or Mood")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    if let bigPrevDate {
                        Text(bigPrevDate.customDate)
                            .font(.title.bold())
                            .padding(.bottom)
                            .padding(.top, 0.5)
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        NavigationLink(
                            destination:
                                LogEmotion(
                                    logStateOfMindModel: logStateOfMindModel,
                                    prevDate: bigPrevDate,
                                    isPrevLog: isPrevLog
                                )
                        ) {
                            ChoiceCard(
                                labelText: "Emotion",
                                labelIcon: "clock",
                                cardText: bigPrevDate == nil ? "How you feel at this very moment." : "How you felt in a previous moment."
                            )
                        }
                        
                        NavigationLink(
                            destination:
                                LogMood(
                                    logStateOfMindModel: logStateOfMindModel,
                                    prevDate: bigPrevDate,
                                    isPrevLog: isPrevLog
                                )
                        ) {
                            ChoiceCard(
                                labelText: "Mood",
                                labelIcon: "sunset.fill",
                                cardText: bigPrevDate == nil ? "How you've felt the whole day." : "How you felt overall that day.",
                                showDate: bigPrevDate != nil ? false : true
                            )
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Cancel") {
                    logStateOfMindModel.cancelStateOfMindFlow()
                }
                .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LogStateOfMindView(
            logStateOfMindModel: LogStateOfMindViewModel()
        )
    }
}

struct TopImages: View {
    var body: some View {
        HStack {
            Spacer()
            TopImage(imageString: "neutral")
            TopImage(imageString: "wink", invert: true)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
        .shadow(radius: 10)
    }
}
struct TopImage: View {
    let size: CGFloat = 100
    let xOffset: CGFloat = 20
    let rotationAngle: CGFloat = 15
    let cornerRadius: CGFloat = 12.0
    let imageString: String
    var invert: Bool = false
    
    var body: some View {
        Image(imageString)
            .resizable()
            .scaledToFill()
            .clipShape(.rect(cornerRadius: cornerRadius))
            .rotationEffect(Angle(degrees: invert ? -rotationAngle : rotationAngle))
            .offset(x: invert ? -xOffset : xOffset)
            .frame(width: size, height: size)
    }
}

struct ChoiceCard: View {
    let labelText: String
    let labelIcon: String
    let cardText: String
    var showTime: Bool = false
    var showDate: Bool = false
    
    @State private var formattedTime: String = ""
    @State private var formattedDate: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label(labelText, systemImage: labelIcon)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .font(.headline.weight(.light))
                
                Text(cardText)
                    .font(.title2.weight(.medium))
                
                Group {
                    if showTime {
                        Text(formattedTime)
                            .foregroundColor(.accent)
                    }
                    
                    if showDate {
                        Text(formattedDate)
                            .foregroundColor(.accent)
                    }
                }
                .font(.caption)
            }
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 12.0))
        .onAppear {
            if showTime {
                formattedTime = Date().formatted(date: .omitted, time: .shortened)
            }
            if showDate {
                formattedDate = Date().customDate
            }
        }
    }
}
