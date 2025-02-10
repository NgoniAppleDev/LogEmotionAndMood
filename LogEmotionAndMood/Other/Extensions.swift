//
//  Extensions.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 7/2/2025.
//

import SwiftUI
import HealthKit

extension Date {
    var normalizedDate: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var customDate: String {
        return self.formatted(.dateTime.weekday()) + ", " + self.formatted(.dateTime.day(.twoDigits)) + " " + self.formatted(.dateTime.month())
    }
}


func getLabelsAsStrings(for labels: [HKStateOfMind.Label]) -> [String] {
    var HKLabelStrings: [String] = []
    
    labels.forEach { label in
        switch label {
        case .amazed:
            HKLabelStrings.append(StateOfMindLabel.amazed.rawValue)
        case .amused:
            HKLabelStrings.append(StateOfMindLabel.amused.rawValue)
        case .angry:
            HKLabelStrings.append(StateOfMindLabel.angry.rawValue)
        case .annoyed:
            HKLabelStrings.append(StateOfMindLabel.annoyed.rawValue)
        case .anxious:
            HKLabelStrings.append(StateOfMindLabel.anxious.rawValue)
        case .ashamed:
            HKLabelStrings.append(StateOfMindLabel.ashamed.rawValue)
        case .brave:
            HKLabelStrings.append(StateOfMindLabel.brave.rawValue)
        case .calm:
            HKLabelStrings.append(StateOfMindLabel.calm.rawValue)
        case .confident:
            HKLabelStrings.append(StateOfMindLabel.confident.rawValue)
        case .content:
            HKLabelStrings.append(StateOfMindLabel.content.rawValue)
        case .disappointed:
            HKLabelStrings.append(StateOfMindLabel.disappointed.rawValue)
        case .discouraged:
            HKLabelStrings.append(StateOfMindLabel.discouraged.rawValue)
        case .disgusted:
            HKLabelStrings.append(StateOfMindLabel.disgusted.rawValue)
        case .drained:
            HKLabelStrings.append(StateOfMindLabel.drained.rawValue)
        case .embarrassed:
            HKLabelStrings.append(StateOfMindLabel.embarrassed.rawValue)
        case .excited:
            HKLabelStrings.append(StateOfMindLabel.excited.rawValue)
        case .frustrated:
            HKLabelStrings.append(StateOfMindLabel.frustrated.rawValue)
        case .grateful:
            HKLabelStrings.append(StateOfMindLabel.grateful.rawValue)
        case .guilty:
            HKLabelStrings.append(StateOfMindLabel.guilty.rawValue)
        case .happy:
            HKLabelStrings.append(StateOfMindLabel.happy.rawValue)
        case .hopeful:
            HKLabelStrings.append(StateOfMindLabel.hopeful.rawValue)
        case .hopeless:
            HKLabelStrings.append(StateOfMindLabel.hopeless.rawValue)
        case .indifferent:
            HKLabelStrings.append(StateOfMindLabel.indifferent.rawValue)
        case .irritated:
            HKLabelStrings.append(StateOfMindLabel.irritated.rawValue)
        case .jealous:
            HKLabelStrings.append(StateOfMindLabel.jealous.rawValue)
        case .joyful:
            HKLabelStrings.append(StateOfMindLabel.joyful.rawValue)
        case .lonely:
            HKLabelStrings.append(StateOfMindLabel.lonely.rawValue)
        case .overwhelmed:
            HKLabelStrings.append(StateOfMindLabel.overwhelmed.rawValue)
        case .passionate:
            HKLabelStrings.append(StateOfMindLabel.passionate.rawValue)
        case .peaceful:
            HKLabelStrings.append(StateOfMindLabel.peaceful.rawValue)
        case .proud:
            HKLabelStrings.append(StateOfMindLabel.proud.rawValue)
        case .relieved:
            HKLabelStrings.append(StateOfMindLabel.relieved.rawValue)
        case .sad:
            HKLabelStrings.append(StateOfMindLabel.sad.rawValue)
        case .satisfied:
            HKLabelStrings.append(StateOfMindLabel.satisfied.rawValue)
        case .scared:
            HKLabelStrings.append(StateOfMindLabel.scared.rawValue)
        case .stressed:
            HKLabelStrings.append(StateOfMindLabel.stressed.rawValue)
        case .surprised:
            HKLabelStrings.append(StateOfMindLabel.surprised.rawValue)
        case .worried:
            HKLabelStrings.append(StateOfMindLabel.worried.rawValue)
        default:
            break
        }
    }
    
    return HKLabelStrings
}

func getAssociationsAsString(for associations: [HKStateOfMind.Association]) -> [String] {
    var HKAssociationStrings: [String] = []
    
    associations.forEach { association in
        switch association {
        case .community:
            HKAssociationStrings.append(StateOfMindAssociations.community.rawValue)
        case .fitness:
            HKAssociationStrings.append(StateOfMindAssociations.fitness.rawValue)
        case .selfCare:
            HKAssociationStrings.append(StateOfMindAssociations.selfCare.rawValue)
        case .hobbies:
            HKAssociationStrings.append(StateOfMindAssociations.hobbies.rawValue)
        case .identity:
            HKAssociationStrings.append(StateOfMindAssociations.identity.rawValue)
        case .spirituality:
            HKAssociationStrings.append(StateOfMindAssociations.spirituality.rawValue)
        case .currentEvents:
            HKAssociationStrings.append(StateOfMindAssociations.currentEvents.rawValue)
        case .dating:
            HKAssociationStrings.append(StateOfMindAssociations.dating.rawValue)
        case .education:
            HKAssociationStrings.append(StateOfMindAssociations.education.rawValue)
        case .family:
            HKAssociationStrings.append(StateOfMindAssociations.family.rawValue)
        case .friends:
            HKAssociationStrings.append(StateOfMindAssociations.friends.rawValue)
        case .health:
            HKAssociationStrings.append(StateOfMindAssociations.health.rawValue)
        case .money:
            HKAssociationStrings.append(StateOfMindAssociations.money.rawValue)
        case .partner:
            HKAssociationStrings.append(StateOfMindAssociations.partner.rawValue)
        case .tasks:
            HKAssociationStrings.append(StateOfMindAssociations.tasks.rawValue)
        case .travel:
            HKAssociationStrings.append(StateOfMindAssociations.travel.rawValue)
        case .weather:
            HKAssociationStrings.append(StateOfMindAssociations.weather.rawValue)
        case .work:
            HKAssociationStrings.append(StateOfMindAssociations.work.rawValue)
        default:
            break
        }
    }
    
    return HKAssociationStrings
}

func getLabelStringsAsHKLabels(for labels: [StateOfMindLabel]) -> [HKStateOfMind.Label] {
    var HKLabels: [HKStateOfMind.Label] = []
    
    labels.forEach { label in
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
    
    return HKLabels
}

func getAssociationStringsAsHKAssociations(for associations: [StateOfMindAssociations]) -> [HKStateOfMind.Association] {
    var HKAssociations: [HKStateOfMind.Association] = []
    
    associations.forEach { association in
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
    
    return HKAssociations
}
