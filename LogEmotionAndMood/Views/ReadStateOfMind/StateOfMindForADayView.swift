//
//  StateOfMindForADayView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 7/2/2025.
//

import SwiftUI
import HealthKit

struct StateOfMindForADayView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    var readStateOfMindModel: ReadStateOfMindViewModel
    var clickedDate: ClickedDate
    
    var stateOfMindForDay: ReadStateOfMindViewModel.StateOfMindForDay {
        readStateOfMindModel.stateOfMindForDay(date: clickedDate.date)
    }
    
    var dayHasDailyMood: Bool {
        readStateOfMindModel.dayHasDailyMood(state: stateOfMindForDay)
    }
    
    var dayHasEmotions: Bool {
        readStateOfMindModel.dayHasEmotions(state: stateOfMindForDay)
    }
    
    var dailyMood: HKStateOfMind? {
        var result: HKStateOfMind? = nil
        stateOfMindForDay.values.forEach { statesOfMind in
            result = statesOfMind.last(where: { $0.kind == .dailyMood })
        }
        return result
    }
    
    var emotions: [HKStateOfMind] {
        var result: [HKStateOfMind] = []
        stateOfMindForDay.values.forEach { statesOfMind in
            result = statesOfMind.filter { $0.kind == .momentaryEmotion }
        }
        return result
    }
    
    var body: some View {
        ZStackWithGradient(
            color: dayHasDailyMood
            ? readStateOfMindModel.getDailyMoodColor(state: stateOfMindForDay)
            : Color(.systemBlue)
        ) {
            VStack {
                ScrollView(showsIndicators: false) {
                    HStack {
                        Spacer()
                        Text("Daily Mood")
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(.bottom, 40)
                    
                    Group {
                        if dayHasDailyMood {
                            DailyMoodView(stateOfMind: dailyMood)
                        } else {
                            ContentUnavailableView {
                                Image(systemName: "calendar.badge.minus")
                            } description: {
                                Text("No Entry.")
                            }
                        }
                    }
                    .padding(.bottom, 30)
                    
                    Divider()
                    
                    HStack {
                        Text("Momentary Emotions")
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                            .font(.footnote)
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.bottom, 40)
                    
                    Group {
                        if dayHasEmotions {
                            MomentaryEmotionsView(emotions: emotions)
                        } else {
                            ContentUnavailableView {
                                Image(systemName: "calendar.badge.minus")
                            } description: {
                                Text("No Entries.")
                            }
                        }
                    }
                }
                .padding()
                
                Button {
                    logStateOfMindModel.isShowingLogView = true
                } label: {
                    Text("Log")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                }
                .background(.accent)
                .clipShape(.capsule)
            }
        }
        .navigationTitle(clickedDate.date.customDate)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") { dismiss() }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $logStateOfMindModel.isShowingLogView) {
            NavigationStack {
                if clickedDate.date.normalizedDate < Date().normalizedDate  {
                    LogStateOfMindView(
                        logStateOfMindModel: logStateOfMindModel,
                        bigPrevDate: Calendar.current.date(
                            bySettingHour: 12, minute: 0, second: 0, of: clickedDate.date
                        ),
                        isPrevLog: true
                    )
                } else {
                    LogStateOfMindView(
                        logStateOfMindModel: logStateOfMindModel
                    )
                }
            }
            .presentationDetents([.large])
        }
        .task {
            await readStateOfMindModel.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        StateOfMindForADayView(
            logStateOfMindModel: LogStateOfMindViewModel(),
            readStateOfMindModel: ReadStateOfMindViewModel(),
            clickedDate: ClickedDate(date: Date())
        )
    }
}

struct DailyMoodView: View {
    var stateOfMind: HKStateOfMind?
    var moodValence: Double? {
        stateOfMind?.valence
    }
    var interpolatedMood: (feeling: String, faceColor: Color, selectedMood: Image) {
        MoodModel.interpolatedMoodMapping(for: moodValence ?? 0)
    }
    var feeling: String {
        return interpolatedMood.feeling
    }
    
    var body: some View {
        VStack {
            Group {
                IconView(
                    faceColor: interpolatedMood.faceColor,
                    selectedMood: interpolatedMood.selectedMood,
                    animateIcon: false,
                    size: .medium
                )
                
            }
            .padding(.bottom, 20)
            
            VStack {
                Text("A \(feeling) Day")
                    .font(.title3.weight(.semibold))
                
                VStack(spacing: 10) {
                    if let stateOfMind, stateOfMind.kind == .dailyMood {
                        Text(ListFormatter.localizedString(byJoining: getLabelsAsStrings(for: stateOfMind.labels)))
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                            .padding(.horizontal, 20)
                            .font(.callout.weight(.light))
                        
                        if stateOfMind.associations.count > 0 {
                            Text("with")
                                .font(.title2.weight(.medium))
                            
                            Text(ListFormatter.localizedString(byJoining: getAssociationsAsString(for: stateOfMind.associations)))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .font(.callout.weight(.light))
                        }
                        
                    }
                }
            }
            
        }
    }
}

struct MomentaryEmotionsView: View {
    var emotions: [HKStateOfMind]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            ForEach(emotions, id: \.uuid) { emotion in
                MomentaryEmotionItem(stateOfMind: emotion)
            }
        }
    }
}

struct MomentaryEmotionItem: View {
    var stateOfMind: HKStateOfMind
    var selectedMood: Image? {
        return MoodModel.moodMappings[stateOfMind.valence]?.selectedMood
    }
    var feeling: String? {
        return MoodModel.moodMappings[stateOfMind.valence]?.feeling
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            if let selectedMood {
                selectedMood
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    if let feeling {
                        Text("\(feeling) Feeling")
                            .font(.callout.weight(.semibold))
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(ListFormatter.localizedString(byJoining: getLabelsAsStrings(for: stateOfMind.labels)))
                            .padding(.top, 5)
                            .font(.callout.weight(.light))
                        
                        if stateOfMind.associations.count > 0 {
                            HStack {
                                Text("with")
                                    .font(.footnote.weight(.medium))
                            }
                            
                            Text(ListFormatter.localizedString(byJoining: getAssociationsAsString(for: stateOfMind.associations)))
                                .font(.callout.weight(.light))
                        }
                        
                    }
                }
            }
            
            Spacer()
            Text(stateOfMind.endDate.formatted(date: .omitted, time: .shortened))
                .fontWeight(.light)
        }
    }
}

