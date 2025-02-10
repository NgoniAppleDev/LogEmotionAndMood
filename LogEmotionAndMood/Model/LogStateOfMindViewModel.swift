//
//  LogStateOfMindViewModel.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI
import HealthKit
import Observation

@Observable
class LogStateOfMindViewModel {
    let healthKitManager = HealthKitManager()
    
    // MARK: View Properties
    var isShowingLogStateOfMind: Bool = false
    var isShowingStateForADay: Bool = false
    var moodValence: CGFloat = 0
    
    var feeling: String {
        MoodModel.moodMappings[moodValence]?.feeling ?? "Neutral"
    }
    
    var faceColor: Color {
        MoodModel.moodMappings[moodValence]?.faceColor ?? Color(.label)
    }
    
    var selectedMood: Image {
        MoodModel.moodMappings[moodValence]?.selectedMood ?? Images.noneFace
    }
    
    var selectedLabels: Set<StateOfMindLabel> = []
    
    var allLabels: [StateOfMindLabel] {
        let items = Set(StateOfMindLabel.allCases.prefix(5)).union(selectedLabels)
        return Array(items.sorted(by: >))
    }
    
    var selectedAssociations: Set<StateOfMindAssociations> = []
    var allAssociations: [StateOfMindAssociations] {
        StateOfMindAssociations.allCases.sorted(by: { $0.rawValue > $1.rawValue })
    }
    
    var kind: HKStateOfMind.Kind = .momentaryEmotion
    
    func cancelStateOfMindFlow() {
        self.isShowingLogStateOfMind = false
        self.moodValence = 0
        self.selectedLabels = []
        self.selectedAssociations = []
    }
    
    func saveStateOfMind(date: Date = Date()) async {
        let store = healthKitManager.healthStore
        
        let sample = await healthKitManager.createSample(
            for: self.kind,
            date: date,
            valence: self.moodValence,
            labels: getLabelStringsAsHKLabels(for: Array(selectedLabels)),
            associations: getAssociationStringsAsHKAssociations(for: Array(selectedAssociations))
        )
        
        print("Succeeded: \(sample.labels) \(sample.associations) \(sample.valence) \(sample.valenceClassification)")
        
        await healthKitManager.save(sample: sample, healthStore: store)
    }
}

