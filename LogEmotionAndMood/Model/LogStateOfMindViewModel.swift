//
//  LogStateOfMindViewModel.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI
import HealthKit
import Observation

struct MoodModel: Identifiable {
    var id = UUID()
    var feeling: String
    var mood: Image
    var color: Color
}

@Observable
class LogStateOfMindViewModel {
    let healthKitManager = HealthKitManager()
    
    // MARK: View Properties
    var isShowingLogStateOfMind: Bool = false
    var moodValence: CGFloat = 0
    
    private let moodMappings: [Double: (feeling: String, faceColor: Color, selectedMood: Image)] = [
        -1: ("Very UnPleasant", .red, Images.unhappyFace),
         -0.5: ("UnPleasant", .blue, Images.sadFace),
         0: ("Neutral", .indigo, Images.normalFace),
         0.5: ("Pleasant", .yellow, Images.goodFace),
         1: ("Very Pleasant", .orange, Images.happyFace)
    ]
    
    var feeling: String {
        moodMappings[moodValence]?.feeling ?? "Neutral"
    }
    
    var faceColor: Color {
        moodMappings[moodValence]?.faceColor ?? Color(.label)
    }
    
    var selectedMood: Image {
        moodMappings[moodValence]?.selectedMood ?? Images.noneFace
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
    
    func saveStateOfMind() async {
        let store = healthKitManager.healthStore
        var HKLabels: [HKStateOfMind.Label] = []
        var HKAssociations: [HKStateOfMind.Association] = []
        
        selectedLabels.forEach { label in
            switch label {
            case .amazed:
                HKLabels.append(HKStateOfMind.Label.amazed)
            case .amused:
                HKLabels.append(HKStateOfMind.Label.amused)
            case .angry:
                HKLabels.append(HKStateOfMind.Label.angry)
            case .annoyed:
                HKLabels.append(HKStateOfMind.Label.annoyed)
            case .anxious:
                HKLabels.append(HKStateOfMind.Label.anxious)
            case .ashamed:
                HKLabels.append(HKStateOfMind.Label.ashamed)
            case .brave:
                HKLabels.append(HKStateOfMind.Label.brave)
            case .calm:
                HKLabels.append(HKStateOfMind.Label.calm)
            case .confident:
                HKLabels.append(HKStateOfMind.Label.confident)
            case .content:
                HKLabels.append(HKStateOfMind.Label.content)
            case .disappointed:
                HKLabels.append(HKStateOfMind.Label.disappointed)
            case .discouraged:
                HKLabels.append(HKStateOfMind.Label.discouraged)
            case .disgusted:
                HKLabels.append(HKStateOfMind.Label.disgusted)
            case .drained:
                HKLabels.append(HKStateOfMind.Label.drained)
            case .embarrassed:
                HKLabels.append(HKStateOfMind.Label.embarrassed)
            case .excited:
                HKLabels.append(HKStateOfMind.Label.excited)
            case .frustrated:
                HKLabels.append(HKStateOfMind.Label.frustrated)
            case .grateful:
                HKLabels.append(HKStateOfMind.Label.grateful)
            case .guilty:
                HKLabels.append(HKStateOfMind.Label.guilty)
            case .happy:
                HKLabels.append(HKStateOfMind.Label.happy)
            case .hopeful:
                HKLabels.append(HKStateOfMind.Label.hopeful)
            case .hopeless:
                HKLabels.append(HKStateOfMind.Label.hopeless)
            case .indifferent:
                HKLabels.append(HKStateOfMind.Label.indifferent)
            case .irritated:
                HKLabels.append(HKStateOfMind.Label.irritated)
            case .jealous:
                HKLabels.append(HKStateOfMind.Label.jealous)
            case .joyful:
                HKLabels.append(HKStateOfMind.Label.joyful)
            case .lonely:
                HKLabels.append(HKStateOfMind.Label.lonely)
            case .overwhelmed:
                HKLabels.append(HKStateOfMind.Label.overwhelmed)
            case .passionate:
                HKLabels.append(HKStateOfMind.Label.passionate)
            case .peaceful:
                HKLabels.append(HKStateOfMind.Label.peaceful)
            case .proud:
                HKLabels.append(HKStateOfMind.Label.proud)
            case .relieved:
                HKLabels.append(HKStateOfMind.Label.relieved)
            case .sad:
                HKLabels.append(HKStateOfMind.Label.sad)
            case .satisfied:
                HKLabels.append(HKStateOfMind.Label.satisfied)
            case .scared:
                HKLabels.append(HKStateOfMind.Label.scared)
            case .stressed:
                HKLabels.append(HKStateOfMind.Label.stressed)
            case .surprised:
                HKLabels.append(HKStateOfMind.Label.surprised)
            case .worried:
                HKLabels.append(HKStateOfMind.Label.worried)
            }
        }
        selectedAssociations.forEach { association in
            switch association {
            case .community:
                HKAssociations.append(HKStateOfMind.Association.community)
            case .fitness:
                HKAssociations.append(HKStateOfMind.Association.fitness)
            case .selfCare:
                HKAssociations.append(HKStateOfMind.Association.selfCare)
            case .hobbies:
                HKAssociations.append(HKStateOfMind.Association.hobbies)
            case .identity:
                HKAssociations.append(HKStateOfMind.Association.identity)
            case .spirituality:
                HKAssociations.append(HKStateOfMind.Association.spirituality)
            case .currentEvents:
                HKAssociations.append(HKStateOfMind.Association.currentEvents)
            case .dating:
                HKAssociations.append(HKStateOfMind.Association.dating)
            case .education:
                HKAssociations.append(HKStateOfMind.Association.education)
            case .family:
                HKAssociations.append(HKStateOfMind.Association.family)
            case .friends:
                HKAssociations.append(HKStateOfMind.Association.friends)
            case .health:
                HKAssociations.append(HKStateOfMind.Association.health)
            case .money:
                HKAssociations.append(HKStateOfMind.Association.money)
            case .partner:
                HKAssociations.append(HKStateOfMind.Association.partner)
            case .tasks:
                HKAssociations.append(HKStateOfMind.Association.tasks)
            case .travel:
                HKAssociations.append(HKStateOfMind.Association.travel)
            case .weather:
                HKAssociations.append(HKStateOfMind.Association.weather)
            case .work:
                HKAssociations.append(HKStateOfMind.Association.work)
            }
        }
        
        let sample = await healthKitManager.createSample(
            for: self.kind,
            valence: self.moodValence,
            labels: HKLabels,
            associations: HKAssociations
        )
        
        print("Succeeded: \(sample.labels) \(sample.associations) \(sample.valence) \(sample.valenceClassification)")
        
        await healthKitManager.save(sample: sample, healthStore: store)
    }
    
}

enum StateOfMindLabel: String, CaseIterable, Comparable {
    case amazed = "Amazed"
    case amused = "Amused"
    case angry = "Angry"
    case annoyed = "Annoyed"
    case anxious = "Anxious"
    case ashamed = "Ashamed"
    case brave = "Brave"
    case calm = "Calm"
    case confident = "Confident"
    case content = "Content"
    case disappointed = "Disappointed"
    case discouraged = "Discouraged"
    case disgusted = "Disgusted"
    case drained = "Drained"
    case embarrassed = "Embarrassed"
    case excited = "Excited"
    case frustrated = "Frustrated"
    case grateful = "Grateful"
    case guilty = "Guilty"
    case happy = "Happy"
    case hopeful = "Hopeful"
    case hopeless = "Hopeless"
    case indifferent = "Indifferent"
    case irritated = "Irritated"
    case jealous = "Jealous"
    case joyful = "Joyful"
    case lonely = "Lonely"
    case overwhelmed = "Overwhelmed"
    case passionate = "Passionate"
    case peaceful = "Peaceful"
    case proud = "Proud"
    case relieved = "Relieved"
    case sad = "Sad"
    case satisfied = "Satisfied"
    case scared = "Scared"
    case stressed = "Stressed"
    case surprised = "Surprised"
    case worried = "Worried"
    
    static func >(lhs: StateOfMindLabel, rhs: StateOfMindLabel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func <(lhs: StateOfMindLabel, rhs: StateOfMindLabel) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}


enum StateOfMindAssociations: String, CaseIterable {
    case community = "Community"
    case fitness = "Fitness"
    case selfCare = "Self Care"
    case hobbies = "Hobbies"
    case identity = "Identity"
    case spirituality = "Spirituality"
    case currentEvents = "Current Events"
    case dating = "Dating"
    case education = "Education"
    case family = "Family"
    case friends = "Friends"
    case health = "Health"
    case money = "Money"
    case partner = "Partner"
    case tasks = "Tasks"
    case travel = "Travel"
    case weather = "Weather"
    case work = "Work"
}
