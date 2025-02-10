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
    var readStateOfMindModel: ReadStateOfMindViewModel
    var clickedDate: ClickedDate
    var stateOfMindForDay: ReadStateOfMindViewModel.StateForMindForDay {
        readStateOfMindModel.stateOfMindForDay(date: clickedDate.date)
    }
    
//    let testStateOfMindForDay: ReadStateOfMindViewModel.StateForMindForDay =
//        .init(
//            stateOfMind: HKStateOfMind(
//                date: Date(),
//                kind: .momentaryEmotion,
//                valence: -1,
//                labels: [HKStateOfMind.Label.amused, HKStateOfMind.Label.confident, HKStateOfMind.Label.excited, HKStateOfMind.Label.grateful, HKStateOfMind.Label.joyful,
//                         HKStateOfMind.Label.joyful,
//                         HKStateOfMind.Label.joyful
//                        ],
//                associations: [
//                    HKStateOfMind.Association.tasks,
//                    HKStateOfMind.Association.hobbies,
//                    HKStateOfMind.Association.money
//                ]
//            ),
//            hasDailyMood: true,
//            hasEmotions: true
//        )
    
    
    
    var body: some View {
        ZStackWithGradient(
            color: MoodModel.moodMappings[
                stateOfMindForDay.stateOfMind != nil
                ? stateOfMindForDay.stateOfMind!.valence
                : 0
            ]?.faceColor ?? Color.indigo
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
                        if stateOfMindForDay.hasDailyMood {
                            DailyMoodView(stateOfMind: stateOfMindForDay.stateOfMind)
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
                        if stateOfMindForDay.hasEmotions {
                            MomentaryEmotionsView(stateOfMind: stateOfMindForDay.stateOfMind, stateOfMindForDay: stateOfMindForDay)
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
                
                Button{} label: {
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") { dismiss() }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StateOfMindForADayView(
            readStateOfMindModel: ReadStateOfMindViewModel(),
            clickedDate: ClickedDate(date: Date())
        )
    }
}

struct DailyMoodView: View {
    var stateOfMind: HKStateOfMind?
    var feeling: String {
        MoodModel.moodMappings[stateOfMind?.valence != nil ? stateOfMind!.valence : 0]!.feeling
    }
    
    var body: some View {
        VStack {
            Group {
                if let stateOfMind {
                    IconView(
                        faceColor: MoodModel.moodMappings[stateOfMind.valence]?.faceColor ?? Color.indigo, selectedMood: MoodModel.moodMappings[stateOfMind.valence]?.selectedMood ?? Images.normalFace,
                        animateIcon: false,
                        size: .medium
                    )
                } else {
                    IconView(faceColor: Color.indigo, selectedMood: Images.normalFace, animateIcon: false)
                }
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
    var stateOfMind: HKStateOfMind?
    var stateOfMindForDay: ReadStateOfMindViewModel.StateForMindForDay
    let testItems: [[Date: HKStateOfMind]] = [
        [Date(): HKStateOfMind(
            date: Date(),
            kind: .momentaryEmotion,
            valence: -1,
            labels: [HKStateOfMind.Label.amused, HKStateOfMind.Label.confident, HKStateOfMind.Label.excited, HKStateOfMind.Label.grateful, HKStateOfMind.Label.joyful,
                     HKStateOfMind.Label.joyful,
                     HKStateOfMind.Label.joyful
                    ],
            associations: [
                HKStateOfMind.Association.tasks,
                HKStateOfMind.Association.hobbies,
                HKStateOfMind.Association.money
            ]
        )],
        [Date(): HKStateOfMind(
            date: Date(),
            kind: .momentaryEmotion,
            valence: -1,
            labels: [HKStateOfMind.Label.amused, HKStateOfMind.Label.confident, HKStateOfMind.Label.excited, HKStateOfMind.Label.grateful, HKStateOfMind.Label.joyful,
                     HKStateOfMind.Label.joyful,
                     HKStateOfMind.Label.joyful
                    ],
            associations: [
                HKStateOfMind.Association.tasks,
                HKStateOfMind.Association.hobbies,
                HKStateOfMind.Association.money
            ]
        )],
        [Date(): HKStateOfMind(
            date: Date(),
            kind: .momentaryEmotion,
            valence: -1,
            labels: [HKStateOfMind.Label.amused, HKStateOfMind.Label.confident, HKStateOfMind.Label.excited, HKStateOfMind.Label.grateful, HKStateOfMind.Label.joyful,
                     HKStateOfMind.Label.joyful,
                     HKStateOfMind.Label.joyful
                    ],
            associations: [
                HKStateOfMind.Association.tasks,
                HKStateOfMind.Association.hobbies,
                HKStateOfMind.Association.money
            ]
        )],
    ]
    var emotions: [HKStateOfMind] {
        var results: [HKStateOfMind] = []
        
        if let items = stateOfMindForDay.allItems {
            items.forEach { item in
                let temp = item.values.filter { $0.kind == .momentaryEmotion }
                temp.forEach { tempItem in
                    results.append(tempItem)
                }
            }
        }
        
        return results
    }
    
    var body: some View {
        VStack {
            ForEach(emotions, id: \.uuid) { emotion in
                MomentaryEmotionItem(stateOfMind: emotion)
            }
        }
    }
}

struct MomentaryEmotionItem: View {
    var stateOfMind: HKStateOfMind?
    var selectedMood: Image? {
        print("selectedMood valence: \(stateOfMind?.valence)")
        return MoodModel.moodMappings[stateOfMind?.valence != nil ? stateOfMind!.valence : 0]?.selectedMood
    }
    var feeling: String? {
        print("feeling valence: \(stateOfMind?.valence)")
        return MoodModel.moodMappings[stateOfMind?.valence != nil ? stateOfMind!.valence : 0]?.feeling
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
                        if let stateOfMind {
                            Text(ListFormatter.localizedString(byJoining: getLabelsAsStrings(for: stateOfMind.labels)))
                                .padding(.top, 5)
                                .font(.callout.weight(.light))
                            
                            if stateOfMind.associations.count > 0 {
                                HStack {
                                    //                                        Spacer()
                                    Text("with")
                                        .font(.footnote.weight(.medium))
                                    //                                        Spacer()
                                }
                                
                                Text(ListFormatter.localizedString(byJoining: getAssociationsAsString(for: stateOfMind.associations)))
                                    .font(.callout.weight(.light))
                            }
                            
                        }
                    }
                }
            }
            
            Spacer()
            if let stateOfMind {
                Text(stateOfMind.endDate.formatted(date: .omitted, time: .shortened))
                    .fontWeight(.light)
            }
        }
        .padding(.bottom, 40)
    }
}


