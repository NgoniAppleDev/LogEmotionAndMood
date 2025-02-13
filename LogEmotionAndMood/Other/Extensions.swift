//
//  Extensions.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 7/2/2025.
//

import SwiftUI
import HealthKit

extension LogStateOfMindViewModel {
    var extractedValues: (moodValence: Double, kind: HKStateOfMind.Kind, feeling: String, faceColor: Color, selectedMood: Image) {
        let interpolatedMood = MoodModel.interpolatedMoodMapping(for: moodValence)
        return (moodValence, kind, interpolatedMood.feeling, interpolatedMood.faceColor, interpolatedMood.selectedMood)
    }
}

extension Date {
    var normalizedDate: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var customDate: String {
        return self.formatted(.dateTime.weekday()) + ", " + self.formatted(.dateTime.day(.twoDigits)) + " " + self.formatted(.dateTime.month())
    }
    
    func getComponents(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    
    init(year: Int = 2025, month: Int = 2, day: Int = 1){
        self = Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
    }
}

// dictionaries are awesome to store data, because to retrieve data they have O(1) -> big O of 1.
private let associationToHKStateOfMindAssociationMap: [StateOfMindAssociations: HKStateOfMind.Association] = [
    .community: .community, .fitness: .fitness, .selfCare: .selfCare, .hobbies: .hobbies,
    .identity: .identity, .spirituality: .spirituality, .currentEvents: .currentEvents,
    .dating: .dating, .education: .education, .family: .family, .friends: .friends,
    .health: .health, .money: .money, .partner: .partner, .tasks: .tasks,
    .travel: .travel, .weather: .weather, .work: .work
]

private let labelToStringMap: [HKStateOfMind.Label: String] = [
    .amazed: StateOfMindLabel.amazed.rawValue,
    .amused: StateOfMindLabel.amused.rawValue,
    .angry: StateOfMindLabel.angry.rawValue,
    .annoyed: StateOfMindLabel.annoyed.rawValue,
    .anxious: StateOfMindLabel.anxious.rawValue,
    .ashamed: StateOfMindLabel.ashamed.rawValue,
    .brave: StateOfMindLabel.brave.rawValue,
    .calm: StateOfMindLabel.calm.rawValue,
    .confident: StateOfMindLabel.confident.rawValue,
    .content: StateOfMindLabel.content.rawValue,
    .disappointed: StateOfMindLabel.disappointed.rawValue,
    .discouraged: StateOfMindLabel.discouraged.rawValue,
    .disgusted: StateOfMindLabel.disgusted.rawValue,
    .drained: StateOfMindLabel.drained.rawValue,
    .embarrassed: StateOfMindLabel.embarrassed.rawValue,
    .excited: StateOfMindLabel.excited.rawValue,
    .frustrated: StateOfMindLabel.frustrated.rawValue,
    .grateful: StateOfMindLabel.grateful.rawValue,
    .guilty: StateOfMindLabel.guilty.rawValue,
    .happy: StateOfMindLabel.happy.rawValue,
    .hopeful: StateOfMindLabel.hopeful.rawValue,
    .hopeless: StateOfMindLabel.hopeless.rawValue,
    .indifferent: StateOfMindLabel.indifferent.rawValue,
    .irritated: StateOfMindLabel.irritated.rawValue,
    .jealous: StateOfMindLabel.jealous.rawValue,
    .joyful: StateOfMindLabel.joyful.rawValue,
    .lonely: StateOfMindLabel.lonely.rawValue,
    .overwhelmed: StateOfMindLabel.overwhelmed.rawValue,
    .passionate: StateOfMindLabel.passionate.rawValue,
    .peaceful: StateOfMindLabel.peaceful.rawValue,
    .proud: StateOfMindLabel.proud.rawValue,
    .relieved: StateOfMindLabel.relieved.rawValue,
    .sad: StateOfMindLabel.sad.rawValue,
    .satisfied: StateOfMindLabel.satisfied.rawValue,
    .scared: StateOfMindLabel.scared.rawValue,
    .stressed: StateOfMindLabel.stressed.rawValue,
    .surprised: StateOfMindLabel.surprised.rawValue,
    .worried: StateOfMindLabel.worried.rawValue
]

private let associationToStringMap: [HKStateOfMind.Association: String] = [
    .community: StateOfMindAssociations.community.rawValue,
    .fitness: StateOfMindAssociations.fitness.rawValue,
    .selfCare: StateOfMindAssociations.selfCare.rawValue,
    .hobbies: StateOfMindAssociations.hobbies.rawValue,
    .identity: StateOfMindAssociations.identity.rawValue,
    .spirituality: StateOfMindAssociations.spirituality.rawValue,
    .currentEvents: StateOfMindAssociations.currentEvents.rawValue,
    .dating: StateOfMindAssociations.dating.rawValue,
    .education: StateOfMindAssociations.education.rawValue,
    .family: StateOfMindAssociations.family.rawValue,
    .friends: StateOfMindAssociations.friends.rawValue,
    .health: StateOfMindAssociations.health.rawValue,
    .money: StateOfMindAssociations.money.rawValue,
    .partner: StateOfMindAssociations.partner.rawValue,
    .tasks: StateOfMindAssociations.tasks.rawValue,
    .travel: StateOfMindAssociations.travel.rawValue,
    .weather: StateOfMindAssociations.weather.rawValue,
    .work: StateOfMindAssociations.work.rawValue
]

private let labelToHKStateOfMindLabelMap: [StateOfMindLabel: HKStateOfMind.Label] = [
    .amazed: .amazed, .amused: .amused, .angry: .angry, .annoyed: .annoyed,
    .anxious: .anxious, .ashamed: .ashamed, .brave: .brave, .calm: .calm,
    .confident: .confident, .content: .content, .disappointed: .disappointed,
    .discouraged: .discouraged, .disgusted: .disgusted, .drained: .drained,
    .embarrassed: .embarrassed, .excited: .excited, .frustrated: .frustrated,
    .grateful: .grateful, .guilty: .guilty, .happy: .happy, .hopeful: .hopeful,
    .hopeless: .hopeless, .indifferent: .indifferent, .irritated: .irritated,
    .jealous: .jealous, .joyful: .joyful, .lonely: .lonely, .overwhelmed: .overwhelmed,
    .passionate: .passionate, .peaceful: .peaceful, .proud: .proud, .relieved: .relieved,
    .sad: .sad, .satisfied: .satisfied, .scared: .scared, .stressed: .stressed,
    .surprised: .surprised, .worried: .worried
]

func getLabelsAsStrings(for labels: [HKStateOfMind.Label]) -> [String] {
    labels.compactMap { labelToStringMap[$0] }
}

func getAssociationsAsString(for associations: [HKStateOfMind.Association]) -> [String] {
    associations.compactMap { associationToStringMap[$0] }
}

func getLabelStringsAsHKLabels(for labels: [StateOfMindLabel]) -> [HKStateOfMind.Label] {
    labels.compactMap { labelToHKStateOfMindLabelMap[$0] }
}

func getAssociationStringsAsHKAssociations(for associations: [StateOfMindAssociations]) -> [HKStateOfMind.Association] {
    associations.compactMap { associationToHKStateOfMindAssociationMap[$0] }
}
